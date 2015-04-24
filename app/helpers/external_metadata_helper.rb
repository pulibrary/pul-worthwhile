module ExternalMetadataHelper
  include PulMetadataServices::ExternalMetadataSource

  def get_preview(id)
    if is_bibdata?(id)
      return { 
        id: id, 
        source: "voyager",
        original_uri: "http://mybook.princeton.edu/121123234", 
        fields: get_voyager_preview(id),
      }
    else
      return { 
        id: id, 
        source: "ead",
        original_uri: "http://myead.princeton.edu/AC230_00002", 
        fields: get_ead_preview(id),
      }
    end
  end

  def get_voyager_preview(id)
    { 
      title: "Voyager thing",
      publisher: "A publisher"
    }
  end

  def get_ead_preview(id)
    { 
      title: "EAD Thing",
      publisher: "A publisher" 
    }
  end

  def is_bibdata?(id)
    if id =~ /\A[-+]?\d+\z/ 
      return true
    else
      return false
    end
  end

end
