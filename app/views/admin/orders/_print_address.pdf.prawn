require 'prawn/layout'

font_name = Spree::Config[:print_invoice_font_name] 
font_normal = Spree::Config[:print_invoice_font_normal] 
font_bold = Spree::Config[:print_invoice_font_bold]

if !font_normal.nil? && !font_bold.nil?
  font_families.update(
    font_name => {:normal => font_normal,
                  :bold => font_bold})
end

font_name ||= "Helvetica"

font font_name, :size => 20

bill_address = @order.bill_address
ship_address = @order.ship_address
shipping_method = @order.shipping_method

(0..4).each do |i|
  bounding_box [0,50+(300*i)], :width => 540 do
    move_down 4

    text "   #{I18n.t(:please_send_to)}", :style => :bold

    move_down 2

    text "      #{ship_address.firstname} #{ship_address.lastname} (#{ship_address.phone})"
    if ship_address.address2.blank?
      text ship_address.address1
    else
      text "      #{ship_address.address1} #{ship_address.address2}"
    end

    text "      #{@order.ship_address.city} #{ship_address.country.name}  #{@order.ship_address.zipcode}" 

    move_down 4

    stroke do
      line_width 0.5
      line bounds.top_left, bounds.top_right
      line bounds.top_left, bounds.bottom_left
      line bounds.top_right, bounds.bottom_right
      line bounds.bottom_left, bounds.bottom_right
    end
  end
end

