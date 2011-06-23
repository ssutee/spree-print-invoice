require 'prawn/layout'

font_name = Spree::Config[:print_invoice_font_name] 

font_normal = Spree::Config[:print_invoice_font_normal] 
font_bold = Spree::Config[:print_invoice_font_bold]
font_italic = Spree::Config[:print_invoice_font_italic]
font_bold_italic = Spree::Config[:print_invoice_font_bold_italic]

font_families.updates(
  font_name => {:normal => font_normal,
                :bold => font_bold,
                :italic => font_italic,
                :bold_italic => font_bold_italic}) unless font_name.nil?

font_name ||= "Helvetica"

im = "#{RAILS_ROOT}/#{Spree::Config[:print_invoice_logo_path]}"

image im , :at => [0,720] #, :scale => 0.35


fill_color "135391"

font font_name

if @hide_prices
  text I18n.t(:packaging_slip), :align => :right, :size => 20
else
  text I18n.t(:customer_invoice), :align => :right, :size => 20
end
fill_color "000000"

move_down 4

font font_name,  :size => 10
text "#{I18n.t(:order_number)} #{@order.number}", :align => :right
text "#{@order.email}", :align => :right

move_down 2
font font_name, :size => 10
text "#{I18n.l @order.completed_at.to_date}", :align => :right

render :partial => "address"

move_down 30

render :partial => "line_items_box"

#move_down 8

# Footer
# render :partial => "footer"
