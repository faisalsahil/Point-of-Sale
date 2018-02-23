class ReportsController < ApplicationController
  # load_and_authorize_resource

  def show
  end

  def sale_report
    if params[:from_date].present? && params[:to_date].present?
      @order_products = OrderProduct.where('DATE(created_at) >= ? AND DATE(created_at) <= ?', params[:from_date].to_date, params[:to_date].to_date)
    elsif params[:from_date].present?
      @order_products = OrderProduct.where('DATE(created_at) >= ?', params[:from_date].to_date)
    elsif params[:to_date].present?
      @order_products = OrderProduct.where('DATE(created_at) <= ?', params[:to_date].to_date)
    else
      @order_products =OrderProduct.where("DATE(created_at) = ?",Date.today)
    end
    respond_to do |format|
      format.html{}
      format.js{ render :layout => false }
      format.pdf do
        render :pdf  => "sale_report",
               disposition:    'attachment',
               layout:         'pdf.html', # use 'pdf.html' for a pdf.html.erb file
               page_offset:    0,
               book:           false,
               orientation:    'Landscape',
               # page_width: '2000',
               # dpi: '300',
               default_header: true,
               lowquality:     false,
               # save_only:       true,
               margin:         { bottom: 10, top: 15 },
               header:         {
                   html:      {
                       template: '/shared/header.pdf.erb', # use :template OR :url
                       layout:   'pdf.html' # optional, use 'pdf_plain.html' for a pdf_plain.html.erb file, defaults to main layout
                   },
                   font_name: 'Times New Roman',
                   font_size: 8,
                   margin:    { left: 0 },
                   line:      false
               }, # optionally you can pass plain html already rendered (useful if using pdf_from_string)
               footer:         {
                   html:      {
                       template: '/shared/footer.pdf.erb', # use :template OR :url
                       layout:   'pdf.html' # optional, use 'pdf_plain.html' for a pdf_plain.html.erb file, defaults to main layout
                   },
                   font_name: 'Times New Roman',
                   font_size: 8,
                   line:      true
               }
      end
    end
  end
end