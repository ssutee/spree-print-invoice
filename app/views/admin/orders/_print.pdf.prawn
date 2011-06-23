require 'prawn/layout'

font_family = Spree::Config[:print_invoice_font_family] || "Helvetica"
font_family_bold = Spree::Config[:print_invoice_font_family_bold] || "Helvetica"
font_family_italic = Spree::Config[:print_invoice_font_family_italic] || "Helvetica"
font_family_bold_italic = Spree::Config[:print_invoice_font_family_bold_italic] || "Helvetica"


font_size = Spree::Config[:print_invoice_font_size] || 18

im = "#{RAILS_ROOT}/#{Spree::Config[:print_invoice_logo_path]}"

image im , :at => [0,720] #, :scale => 0.35


fill_color "135391"

font font_family

if @hide_prices
  text I18n.t(:packaging_slip), :align => :right, :size => font_size
else
  text I18n.t(:customer_invoice), :align => :right, :size => font_size
end
fill_color "000000"

move_down 4

font font_family,  :size => font_size/2 
text "#{I18n.t(:order_number)} #{@order.number}", :align => :right
text "#{@order.email}", :align => :right

move_down 2
font font_family, :size => font_size/2
text "#{I18n.l @order.completed_at.to_date}", :align => :right

render :partial => "address"

move_down 30

render :partial => "line_items_box"

#move_down 8

# Footer
# render :partial => "footer"
