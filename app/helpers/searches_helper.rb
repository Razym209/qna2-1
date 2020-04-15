module SearchesHelper
  def search_result_link(params)
    text = params[:data].length > 20 ? "#{params[:data][0, 20]}..." : params[:data]
    if [:question].include?(params[:type])
      link_to text, eval("#{params[:type].to_s}_path(#{params[:id]})")
    else
      text
    end
  end
end
