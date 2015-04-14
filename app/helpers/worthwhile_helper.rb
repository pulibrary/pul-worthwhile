module WorthwhileHelper
  include ::BlacklightHelper
  include Worthwhile::MainAppHelpers


  # Override broken implementation of current_users_collections in worthwhile
  # Defaults to returning a list of all collections.
  # If you have implement User.collections, the results of that will be used.
  def current_users_collections
    if current_user.respond_to?(:collections)
      current_user.collections.map { |c| [c.title.join(', '), c.id] }
    else
      query = ActiveFedora::SolrQueryBuilder.construct_query_for_rel(has_model: ::Collection.to_class_uri)
      ActiveFedora::SolrService.query(query, fl: 'title_tesim id',
                                      rows: 1000).map do |r|
        [r['title_tesim'].join(', '), r['id']]
      end.sort { |a, b| a.first <=> b.first }
    end
  end
end
