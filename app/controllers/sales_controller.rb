class SalesController < ApplicationController
  def new
    @thesale = Sale.new
  end

  def create
    # raise
    detalle = params[:sale][:detail]
    categoria = params[:sale][:category]
    valor = params[:sale][:value].to_i
    descuento = params[:sale][:discount].to_i.to_f
    iva = params[:iva].to_i
    cod = DateTime.now.to_i

    con_descuento = (1 - (descuento / 100)) * valor
    if iva != 1
      total = 1.19 * con_descuento
      iva = 19
    else
      total = con_descuento
      iva = 0
    end

    sale = Sale.new(cod: cod, detail: detalle, category: categoria, value: valor, discount: descuento, tax: iva, total: total)
    # byebug
    if sale.save
      redirect_to sales_done_path, notice: 'El registro fue almacenado con exito'
    else
      redirect_to sales_done_path, notice: 'El registro no fue almacenado :('
    end
  end

  def done
    @sale = Sale.last
  end
end
