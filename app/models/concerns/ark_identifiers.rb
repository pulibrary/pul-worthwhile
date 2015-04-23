require "ezid-client"

module ArkIdentifiers
  extend ActiveSupport::Concern

  included do
    property :ark, predicate: ::RDF::URI.new(::RDF::Vocab::IANA.canonical), multiple: false
  end

  def set_ark(target)
    self.ark ||= mint_ark(target)
    self.ark
  end

  private

  def mint_ark(target)

    # Mint ARK if the target is a url.
    if target =~ /\A#{URI::regexp(['http', 'https'])}\z/
      Ezid::Identifier.create(target: target).id
    end
  end
end