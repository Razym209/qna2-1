class Services::Search
  def self.call(types, query)
    type_rules = { question: :title, answer: :body, comment: :body, user: :email }

    types = type_rules.keys if types.empty?

    @search_results_all = []

    types.each do |type|
      search_results = type.to_s.capitalize.constantize.search(query)
      if search_results.present?
        search_results = search_results.map { |search_result| { type: type, id: search_result.id, data: search_result.send(type_rules[type])} }
        @search_results_all << search_results
      end
    end
    @search_results_all.flatten
  end
end
