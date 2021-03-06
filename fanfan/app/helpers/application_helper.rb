# -*- coding: utf-8 -*-
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

  def currency_symbol
    '<span style="font-family: Arial">&yen;</span>'.html_safe
  end

  def format_money(money)
    money ||= 0
    str="<span class='number"
    str += " negative-number" if money < 0
    str += " positive-number" if money >= 0
    str += "'>"
    str += "￥" + "%.2f" % money
    str += "</span>"

    str.html_safe

  end
end
