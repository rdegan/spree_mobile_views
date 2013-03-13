Spree::BaseHelper.module_eval do

  def link_to_cart(text = nil)
    text = text ? h(text) : t('cart')

    if current_order.nil? or current_order.line_items.empty?
      text = "#{text}: (#{t('empty')})"
    else
      text = "#{text}: (#{current_order.item_count}) #{current_order.display_total}"
    end

    link_to text, spree.cart_path, :class => css_class(spree.cart_path)
  end

  def css_class(path)
    current_page?(path) ? "ui-btn-active" : ""
  end

  def copyright
    "<p>#{t(:powered_by)} <a href=\"http://spreecommerce.com/\">Spree Commerce</a></p>".html_safe
  end

  def hook(hook_name, locals = {}, &block)
    warn "[DEPRECATION] `hook` is deprecated"
    content = block_given? ? capture(&block) : ''
    "<div data-hook=\"#{hook_name}\">#{content}</div>".html_safe
  end
end
