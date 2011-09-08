module ApplicationHelper
  def remote_function(options)
    method = options[:url][:method] || "GET"

    function = "jQuery.ajax({"
    function << "type: '#{method}'"
    function << ",url: '#{url_for options[:url]}'"
    function << ",data: #{options[:data]}" if options[:data]
    if update = options[:update]
      function << ",success: function(data){ jQuery('##{update}').html(data)}"
    end
    function << "})"
    return function.html_safe

  end

  def format_money(money)
    str="<span class='number"
    str += " negative-number" if money < 0
    str += "'>"
    str += "$ " + money.round(2).to_s
    str += "</span>"
  end
end
