require 'open-uri'
require 'zip'
require 'fileutils'

PUL_DAM_CONFIG = YAML.load_file(Rails.root.join('config', 'pul_dam.yml'))

final_dir = Rails.root.join(PUL_DAM_CONFIG['fits_dir'])

open(PUL_DAM_CONFIG['fits_download'], 'rb') do |tmp|
  Zip::File.open(tmp.path) do |zipfile|
    unzip_root = nil
    zipfile.each do |e| # e is a Zip::Entry
      fpath = File.join("/tmp", e.to_s)
      unzip_root = fpath if unzip_root.nil?
      FileUtils.mkdir_p(File.dirname(fpath))
      zipfile.extract(e, fpath){ true }
    end
    FileUtils.mv(unzip_root.to_s, final_dir.to_s)
    File.chmod(0755, File.join(final_dir.to_s, 'fits.sh'))
  end
end
