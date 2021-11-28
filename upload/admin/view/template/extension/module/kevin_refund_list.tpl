<?php echo $header; ?><?php echo $column_left; ?>
<div id="content">
  <div class="page-header">
    <div class="container-fluid">
      <div class="pull-right">
      <!--
          <button type="button" id="button-delete" form="form-order" formaction="delete link" data-toggle="tooltip" title="delete" class="btn btn-danger"><i class="fa fa-trash-o"></i></button> -->
      </div>
      <h1><?php echo $heading_title; ?></h1>
      <ul class="breadcrumb">
        <?php foreach ($breadcrumbs as $breadcrumb) { ?> 
        <li><a href="<?php echo $breadcrumb['href']; ?>"><?php echo $breadcrumb['text']; ?></a></li>
        <?php } ?>
      </ul>
    </div>
  </div>
  <div class="container-fluid">
	<?php if ($text_sandbox_alert) { ?> 
    <div class="alert alert-warning"><i class="fa fa-exclamation-circle"></i> <?php echo $text_sandbox_alert; ?> 
     <!-- <button type="button" class="close" data-dismiss="alert">&times;</button>-->
    </div>
	<?php } ?>
	 <?php if ($refund_warning) { ?> 
    <div class="alert alert-warning"><i class="fa fa-exclamation-circle"></i> <?php echo $refund_warning; ?> 
     <!-- <button type="button" class="close" data-dismiss="alert">&times;</button>-->
    </div>
	<?php } ?>
	<?php if ($error_refund) { ?> 
    <div class="alert alert-danger"><i class="fa fa-exclamation-circle"></i> <?php echo $error_refund; ?>
      <button type="button" class="close" data-dismiss="alert">&times;</button>
    </div>
    <?php } ?>
	  <?php if ($error_client) { ?> 
    <div class="alert alert-danger"><i class="fa fa-exclamation-circle"></i> <?php echo $error_client; ?>
      <button type="button" class="close" data-dismiss="alert">&times;</button>
    </div>
    <?php } ?>
    <?php if ($error_warning) { ?> 
    <div class="alert alert-danger"><i class="fa fa-exclamation-circle"></i> <?php echo $error_warning; ?>
      <button type="button" class="close" data-dismiss="alert">&times;</button>
    </div>
    <?php } ?>
	<?php if ($success_refund) { ?> 
    <div class="alert alert-success"><i class="fa fa-exclamation-circle"></i> <?php echo $success_refund; ?>
      <button type="button" class="close" data-dismiss="alert">&times;</button>
    </div>
    <?php } ?>
    <?php if ($success) { ?> 
    <div class="alert alert-success"><i class="fa fa-check-circle"></i> <?php echo $success; ?>
      <button type="button" class="close" data-dismiss="alert">&times;</button>
    </div>
    <?php } ?>
    <div class="panel panel-default">
      <div class="panel-heading">
        <h3 class="panel-title"><i class="fa fa-list"></i> <?php echo $text_list; ?></h3>
      </div>
      <div class="panel-body">
        <div class="well">
          <div class="row">
            <div class="col-sm-4">
              <div class="form-group">
                <label class="control-label" for="input-order-id"><?php echo $entry_order_id; ?></label>
                <input type="text" name="filter_order_id" value="<?php echo $filter_order_id; ?>" placeholder="<?php echo $entry_order_id; ?>" id="input-order-id" class="form-control" />
              </div>
              <div class="form-group">
                <label class="control-label" for="input-customer"><?php echo $entry_customer; ?></label>
                <input type="text" name="filter_customer" value="<?php echo $filter_customer; ?>" placeholder="<?php echo $entry_customer; ?>" id="input-customer" class="form-control" />
              </div>
            </div>
            <div class="col-sm-4">
              <div class="form-group">
                <label class="control-label" for="input-order-status"><?php echo $entry_order_status; ?></label>
                <select name="filter_order_status" id="input-order-status" class="form-control">
                  <option value="*"></option>
                  <?php if ($filter_order_status == '0') { ?> 
                  <option value="0" selected="selected"><?php echo $text_missing; ?></option>
                  <?php } else { ?>
                  <option value="0"><?php echo $text_missing; ?></option>
                  <?php } ?>
                  <?php foreach ($order_statuses as $order_status) { ?> 
                  <?php if ($order_status['order_status_id'] == $filter_order_status) { ?> 
                  <option value="<?php echo $order_status['order_status_id']; ?>" selected="selected"><?php echo $order_status['name']; ?></option>
                  <?php } else { ?>
                  <option value="<?php echo $order_status['order_status_id']; ?>"><?php echo $order_status['name']; ?></option>
                  <?php } ?>
                  <?php } ?>
                </select>
              </div>
              <div class="form-group">
                <label class="control-label" for="input-total"><?php echo $entry_total; ?></label>
                <input type="text" name="filter_total" value="<?php echo $filter_total; ?>" placeholder="<?php echo $entry_total; ?>" id="input-total" class="form-control" />
              </div>
            </div>
            <div class="col-sm-4">
              <div class="form-group">
                <label class="control-label" for="input-date-added"><?php echo $entry_date_added; ?></label>
                <div class="input-group date">
                  <input type="text" name="filter_date_added" value="<?php echo $filter_date_added; ?>" placeholder="<?php echo $entry_date_added; ?>" data-date-format="YYYY-MM-DD" id="input-date-added" class="form-control" />
                  <span class="input-group-btn">
                  <button type="button" class="btn btn-default"><i class="fa fa-calendar"></i></button>
                  </span></div>
              </div>
              <div class="form-group">
                <label class="control-label" for="input-date-modified"><?php echo $entry_date_modified; ?></label>
                <div class="input-group date">
                  <input type="text" name="filter_date_modified" value="<?php echo $filter_date_modified; ?>" placeholder="<?php echo $entry_date_modified; ?>" data-date-format="YYYY-MM-DD" id="input-date-modified" class="form-control" />
                  <span class="input-group-btn">
                  <button type="button" class="btn btn-default"><i class="fa fa-calendar"></i></button>
                  </span></div>
              </div>
              <button type="button" id="button-filter" class="btn btn-primary pull-right"><i class="fa fa-filter"></i> <?php echo $button_filter; ?></button>
            </div>
          </div>
        </div>
          <div class="table-responsive">
            <table class="table table-bordered table-hover">
              <thead>
                <tr>
                  <td style="width: 1px;" class="text-center"><input type="checkbox" onclick="$('input[name*=\'selected\']').prop('checked', this.checked);" /></td>
                  <td class="text-right"><?php if ($sort == 'o.order_id') { ?> 
                    <a href="<?php echo $sort_order; ?>" class="<?php echo strtolower($order); ?>"><?php echo $column_order_id; ?></a>
                    <?php } else { ?>
                    <a href="<?php echo $sort_order; ?>"><?php echo $column_order_id; ?></a>
                    <?php } ?></td>
                  <td class="text-left"><?php if ($sort == 'customer') { ?> 
                    <a href="<?php echo $sort_customer; ?>" class="<?php echo strtolower($order); ?>"><?php echo $column_customer; ?></a>
                    <?php } else { ?>
                    <a href="<?php echo $sort_customer; ?>"><?php echo $column_customer; ?></a>
                    <?php } ?></td>
                  <td class="text-left"><?php if ($sort == 'order_status') { ?> 
                    <a href="<?php echo $sort_status; ?>" class="<?php echo strtolower($order); ?>"><?php echo $column_status; ?></a>
                    <?php } else { ?>
                    <a href="<?php echo $sort_status; ?>"><?php echo $column_status; ?></a>
                    <?php } ?></td>
                  <td class="text-right"><?php if ($sort == 'o.total') { ?> 
                    <a href="<?php echo $sort_total; ?>" class="<?php echo strtolower($order); ?>"><?php echo $column_total; ?></a>
                    <?php } else { ?>
                    <a href="<?php echo $sort_total; ?>"><?php echo $column_total; ?></a>
                    <?php } ?></td>

					<td class="text-right"><?php if ($sort == 'kr.amount_available') { ?>  
                    <a href="<?php echo $sort_amount_available; ?>" class="<?php echo strtolower($order); ?>"><?php echo $column_amount_available; ?></a>
                    <?php } else { ?>
                    <a href="<?php echo $sort_amount_available; ?>"><?php echo $column_amount_available; ?></a>
                    <?php } ?></td>
					
				  <td class="text-right"><?php if ($sort == 'total_amount') { ?>  
                    <a href="<?php echo $sort_total_amount; ?>" class="<?php echo strtolower($order); ?>"><?php echo $column_amount; ?></a>
                    <?php } else { ?>
                    <a href="<?php echo $sort_total_amount; ?>"><?php echo $column_amount; ?></a>
                    <?php } ?></td>
					
					<td class="text-right"><?php if ($sort == 'refund_action') { ?>  
                    <a href="<?php echo $sort_refund_action; ?>" class="<?php echo strtolower($order); ?>"><?php echo $column_refund_action; ?></a>
                    <?php } else { ?>
                    <a href="<?php echo $sort_refund_action; ?>"><?php echo $column_refund_action; ?></a>
                    <?php } ?></td>

                  <td class="text-left"><?php if ($sort == 'o.date_added') { ?> 
                    <a href="<?php echo $sort_date_added; ?>" class="<?php echo strtolower($order); ?>"><?php echo $column_date_added; ?></a>
                    <?php } else { ?>
                    <a href="<?php echo $sort_date_added; ?>"><?php echo $column_date_added; ?></a>
                    <?php } ?></td>
                  <td class="text-left"><?php if ($sort == 'o.date_modified') { ?> 
                    <a href="<?php echo $sort_date_modified; ?>" class="<?php echo strtolower($order); ?>"><?php echo $column_date_modified; ?></a>
                    <?php } else { ?>
                    <a href="<?php echo $sort_date_modified; ?>"><?php echo $column_date_modified; ?></a>
                    <?php } ?></td>
                  <td class="text-right"><?php echo $column_action; ?></td>
                </tr>
              </thead>
              <tbody>
                <?php if ($orders) { ?> 
                <?php foreach ($orders as $order) { ?> 
                <tr> 
                  <td class="text-center"><?php if (in_array($order['order_id'], $selected)) { ?>
                    <input type="checkbox" name="selected[]" value="<?php echo $order['order_id']; ?>" checked="checked" />
                    <?php } else { ?>
                    <input type="checkbox" name="selected[]" value="<?php echo $order['order_id']; ?>" />
                    <?php } ?>
                    <input type="hidden" name="shipping_code[]" value="<?php echo $order['shipping_code']; ?>" /></td>
                  <td class="text-right"><?php echo $order['order_id']; ?></td>
                  <td class="text-left"><?php echo $order['customer']; ?></td>
                  <td class="text-left"><?php echo $order['order_status']; ?></td>
                  <td class="text-right"><?php echo $order['total']; ?></td>
				  <td <?php if ($order['refund_available']) { ?>  style="background-color: #fffef5; color: red;" <?php } ?> class="text-right"><?php echo $order['amount_available']; ?></td>
				  <td class="text-right"><?php echo $order['amount']; ?></td>
				  <td class="text-right"><?php echo $order['refund_action']; ?></td>
                  <td class="text-left"><?php echo $order['date_added']; ?></td>
                  <td class="text-left"><?php echo $order['date_modified']; ?></td>

				
					<td class="text-right"><a href="<?php echo $order['view']; ?>" data-dismiss="modal" data-toggle="tooltip" title="<?php echo $button_view; ?>" class="btn btn-info"><i class="fa fa-eye"></i></a>
					<a href=""  class="btn btn-primary" data-toggle="modal" data-target="#kevin-refund<?php echo $order['order_id']; ?>"><i data-toggle="tooltip" title="<?php echo $button_refund; ?>" class="fa fa-money"></i></a></td>
                </tr>
				  <!-- refund modal -->	
				<div class="modal fade" id="kevin-refund<?php echo $order['order_id']; ?>" tabindex="-1" role="dialog" aria-labelledby="myModalLabel"
			  aria-hidden="true">
			  <div class="modal-dialog" role="document">
					  
				<div class="modal-content">
				  <div class="modal-header text-center">
					<h4 class="modal-title w-100 font-weight-bold"><?php echo $text_refund_order_id; ?> <?php echo $order['order_id']; ?></h4>
					<button type="button" class="close kevin-refund-close" data-dismiss="modal" aria-label="Close">
					  <span aria-hidden="true">&times;</span>
					</button>
				  </div>
					<form method="post" action="<?php echo $order['refund_kevin']; ?>" enctype="multipart/form-data" id="form-kevin-refund-<?php echo $order['order_id']; ?>">
					<div class="modal-body">
						
						<div calss="product-grid" >
						<?php $product_row = 0; ?>
						<?php foreach ($order['products'] as $product) { ?> 
					 <div class="form-refund">
						<label class="col-sm-6 control-label text-right refund-label" for="input-clientid"><?php echo $text_product_restock; ?><div style="font-weight: 700;"><?php echo $product['name']; ?></div></label>
						<div class="product-select col-sm-6">
						<label class="col-sm-2 control-label text-right refund-label" for="input-product-quantity<?php echo $product_row; ?><?php echo $order['order_id']; ?>"><?php echo $text_Qty; ?></label>
						<div class="col-sm-6 refund-grid">
						
							<select  data-price="<?php echo $product['price']; ?>" data-product_id="<?php echo $product['product_id']; ?>" name="kevin_refund_restock[<?php echo $product['product_id']; ?>]" id="input-product-quantity<?php echo $product_row; ?><?php echo $order['order_id']; ?>" class="form-control products-quantity<?php echo $order['order_id']; ?> restock-option<?php echo $product['product_id']; ?>">
							
						<?php foreach ($product['quantity_array'] as $quantity) { ?> 		
                  		<option value="<?php echo $quantity; ?>"><?php echo $quantity; ?></option>
						<?php } ?>		
                		</select>
								
							</div> 

						</div>
					 </div>
						<?php $product_row++; ?>
						 <?php } ?>
						</div>
						
					  <div class="form-refund">
						<label class="col-sm-6 control-label text-right refund-label" for="input-refunded"><?php echo $text_refunded; ?></label>
						<div class="col-sm-6 refund-grid text-right refund-label">
						  <?php echo $order['amount']; ?>

						</div>
					 </div>
						 
					  <div class="form-refund">
						<label class="col-sm-6 control-label  text-right refund-label" for="input-available"><?php echo $text_refund_available; ?></label>
						<div class="col-sm-6 refund-grid  text-right refund-label">
						  <?php echo $order['amount_available']; ?>

						</div>
					 </div>
						
					 
					  <div class="form-refund">
						<label class="col-sm-6 control-label text-right refund-label" for="input-refund<?php echo $order['order_id']; ?>"><?php echo $text_refund_amount; ?>&nbsp;<div style="font-weight: 700; color:red; float: right;">*</div></label>
						<div class="col-sm-6 refund-grid">
						  <input type="text" name="kevin_refund_amount" value="" placeholder="<?php echo $text_refund_amount; ?>" id="input-refund<?php echo $order['order_id']; ?>" class="form-control input-refund" />

						</div>
					 </div>
						 
					  <div class="form-refund">
						<label class="col-sm-6 control-label text-right refund-label" for="input-reason"><?php echo $text_reason; ?></label>
						<div class="col-sm-6 refund-grid">
						  <input type="text" name="kevin_refund_reason" value="" placeholder="<?php echo $text_reason; ?>" id="input-reason" class="form-control" />

						</div>
					 </div> 
						
						<input type="hidden" name="payment_id" value="<?php echo $order['payment_id']; ?>" id="payment-id" class="form-control" />

						</div>
					
					<script type="text/javascript"><!--
						$(document).ready(function(){
						var product_row = <?php echo $product_row; ?>;
						var order_id = <?php echo $order['order_id']; ?>;
						
						for (i = 0; i <= product_row; i++) {	
							$("#input-product-quantity"+i+order_id).on('change', function (e) {
								e.preventDefault();
								var products = [];
								$('select.products-quantity' + order_id).each(function(){
									var $this = $(this);
									products.push([ $this.data(), $this.val() ]);
								});
								console.log(products);
								checkQuantity(products, order_id);
							});
						}

							$("#input-refund<?php echo $order['order_id']; ?>").keyup(function(e){
								e.preventDefault();
								var input_value = $(this).val();
								input_value = input_value.replace(/,/g, '.')
								var currentText = parseFloat(input_value).toFixed(2);
								var symbol_left = "<?php echo $order['currency_symbol_left']; ?>";
								var symbol_right = "<?php echo $order['currency_symbol_right']; ?>";
								$("#refund-amount<?php echo $order['order_id']; ?>").text(symbol_left + currentText + symbol_right);
								if (!currentText) {
									$("#refund-amount<?php echo $order['order_id']; ?>").text(symbol_left + '0.00' + symbol_right);
								}
							});
							
							$("#kevin-refund-amount<?php echo $order['order_id']; ?>").on('click', function (e) {
								e.preventDefault();
								if($("#input-refund<?php echo $order['order_id']; ?>").val() == ''){ 
									alert('<?php echo $text_refund_empty; ?>');
								} else {
									if (confirm('<?php echo $text_confirm_refund; ?>')) {
										$("#form-kevin-refund-<?php echo $order['order_id']; ?>").submit();
									} else {
										return false;
									}
								}
							});
						});
						
					//--></script> 
						
				  <div class="modal-footer d-flex justify-content-center"> 
					<div class="checkbox notify-checkbox col-sm-6">
					<label class="control-label col-sm-5 text-right notify-label" for="input-notify-<?php echo $order['order_id']; ?>"><?php echo $entry_notify; ?></label>
					<input type="checkbox" class="col-sm-1 text-right" id="input-notify" name="notify_refund" value="1" /> </div>
					 <button id="kevin-refund-amount<?php echo $order['order_id']; ?>" form="form-kevin-refund-<?php echo $order['order_id']; ?>"  class="btn btn-primary kevin-refund-amount"><?php echo $text_refund; ?>&nbsp;<div id="refund-amount<?php echo $order['order_id']; ?>"><?php echo $order['amount_0']; ?></div></button>
					  
				  </div>

					</form>	
				</div>
				  
			  </div>
			</div>				
                <?php } ?> 
                <?php } else { ?>
                <tr>
                  <td class="text-center" colspan="11"><?php echo $text_no_results; ?></td>
                </tr>
                <?php } ?>
              </tbody>
            </table>
          </div>
        
        <div class="row">
          <div class="col-sm-6 text-left"><?php echo $pagination; ?></div>
          <div class="col-sm-6 text-right"><?php echo $results; ?></div>
        </div>
      </div>
    </div>
  </div>

<style>
#input-notify {
	position: relative;
	float: right;
	margin-left: 10px;
}
.notify-label {
	width: 100% !important;
	margin-left: -20px;	
}
.product-select.col-sm-6 {
 /**/   width: 50%;
    float: right;
	margin-left: 15px;
	margin-right: -15px;
}
	
.control-label {
    width: 50%;
}
.modal-body.product-grid {
/*	display: flex;
    align-items: stretch;
    flex-direction: column;
    flex-wrap: nowrap;	*/
}
@media screen and (max-device-width: 320px)  
  and (-webkit-min-device-pixel-ratio: 1) { 
	  .kevin-refund-amount {
		  display: block;
		  width: 100%;
		  margin-bottom: 5px;
	  }
	  .modal-footer {
		  display: grid;
    	  justify-items: end;
	  }
}
	
.kevin-refund-amount {
 /*   display: inline-flex;*/
	display: -webkit-inline-flex;
	display: -webkit-box;       /* iOS 6-, Safari 3.1-6 */
	display: -moz-box;         /* Firefox 19 */
    display: -ms-flexbox;      /* IE 10 */
    display: -webkit-flex;     /* Chrome */
    display: flex;             /* Opera 12.1, Firefox 20+ */
	font-size: 14px;
    font-weight: 400;
	float: right;
}
label.refund-label {
    font-size: 12px;
    font-weight: 400;
    margin-top: 5px;
}
.refund-grid.refund-label {
    font-size: 14px;
    font-weight: 600;
    margin-top: 5px;
}
.refund-grid {
  /*  width: 50%;*/
    float: right;
}
.checkbox.checkbox-kevin {
    float: right;
}
.notify-checkbox {
    /* display: inline-flex; */
    display: -webkit-inline-flex;
    display: -webkit-box;
    display: -moz-box;
    display: -ms-flexbox;
    display: -webkit-flex;
    display: flex;
    align-items: center;
    justify-content: space-between;
    flex-direction: row;
}
.form-refund {
	padding-bottom: 15px;
    /* padding-bottom: 6.5vh; */
    display: -webkit-inline-flex;
	display: -webkit-box;       /* iOS 6-, Safari 3.1-6 */
	display: -moz-box;         /* Firefox 19 */
    display: -ms-flexbox;      /* IE 10 */
    display: -webkit-flex;     /* Chrome */
    display: flex;             /* Opera 12.1, Firefox 20+ */
    align-items: center;
    justify-content: space-between;
    flex-direction: row;
}
button.kevin-refund-close {
    outline: none !important;
    font-size: 32px !important;
    font-weight: 400 !important;
	position: relative;
    top: -26px;
}
/*When the modal fills the screen it has an even 2.5% on top and bottom*/
/*Centers the modal*/
.modal-dialog {
	margin: 2.5vh auto;
}

.modal-content {
 /* max-height: 95vh;*/
	overflow: hidden;
}

/*Sets the maximum height of the modal body to 90% of the screen height*/
.modal-body {
	min-height: 23vh;
	margin-left: -15px;
    margin-right: -15px;
}

</style>
	
<script type="text/javascript"><!--
	
var checkQuantity = function (products, order_id) {
console.log(products);	console.log(order_id);	
	var  jsonObj = [];
	$.each(products, function(key, value) {
		pr = {key:value}
		item = {}
        item [key] = value;
        jsonObj.push(item);
	});
	var prod = JSON.stringify(jsonObj);

	$.ajax({
		url: 'index.php?route=extension/module/kevin_refund/checkQuantity&token=<?php echo $token; ?>&order_id=' + order_id + '&products=' + encodeURIComponent(prod),
		type: 'post',
		dataType: 'json',
		beforeSend: function() {
		//	$('#button').button('loading');
		},
		complete: function() {
		//	$('#button').button('reset');
		},
		success: function(json) {
			var order_id = json['order_id']
			$('.alert-dismissible').remove();
			$('.has-error').removeClass('has-error');
			if(json['products'] && json['products'] != '') {

				for (i = 0; i < json['products'].length; i++) {

					if (json['products'][i]['product_id']) {
						var restocked_quantiy = json['products'][i]['restocked_quantity'] ? json['products'][i]['restocked_quantity'] : 0;
						var restock_quantiy = json['products'][i]['restock_quantity'] ? json['products'][i]['restock_quantity'] : 0;
						var ordered_quantiy = json['products'][i]['ordered_quantity'] ? json['products'][i]['ordered_quantity'] : 0;

						if ((ordered_quantiy < (1*restocked_quantiy + 1*restock_quantiy)) && restocked_quantiy) {
							$('.qunqtity-danger'+json['products'][i]['product_id']).addClass('has-error');
						
							alert('You can\'t restock ' + restock_quantiy + ' pcs. of this product: ' + json['products'][i]['name']+ '. The product already restocked. You can choose less quantity for restock...');
							
							$(".restock-option"+json['products'][i]['product_id']).val('0');
							if (restock_quantiy === 0) {
								$('.has-error').removeClass('has-error');
							}
						} 
					}
						
					if (json['products'][i]['restock_quantity'] == 0) {
						$("#input-refund"+json['order_id']).val('');
						$("#refund-amount"+json['order_id']).text(json['refund_amount_text']);
					} 
				}
			}
			if (json['refund_amount']) {
				var refund_total = parseFloat(json['refund_amount']).toFixed(2);
				$("#input-refund"+json['order_id']).val(refund_total);
				$("#refund-amount"+json['order_id']).text(json['refund_amount_text']);
			}
		},
		error: function(xhr, ajaxOptions, thrownError) {
			alert(thrownError + "\r\n" + xhr.statusText + "\r\n" + xhr.responseText);
		}
	});	
}
	
//--></script>	
<script type="text/javascript"><!--
(function($) {
  $.fn.inputFilter = function(inputFilter) {
    return this.on("input keydown keyup mousedown mouseup select contextmenu drop", function() {
      if (inputFilter(this.value)) {
        this.oldValue = this.value;
        this.oldSelectionStart = this.selectionStart;
        this.oldSelectionEnd = this.selectionEnd;
      } else if (this.hasOwnProperty("oldValue")) {
        this.value = this.oldValue;
        this.setSelectionRange(this.oldSelectionStart, this.oldSelectionEnd);
      } else {
        this.value = "";
      }
    });
  };
}(jQuery));
$("input.input-refund").inputFilter(function(value) {
  return /^-?\d*[.,]?\d{0,2}$/.test(value);	
}); 
//--></script>	
	
  	
  <script type="text/javascript"><!--
$('#button-filter').on('click', function() {
	url = 'index.php?route=extension/module/kevin_refund&token=<?php echo $token; ?>';

	var filter_order_id = $('input[name=\'filter_order_id\']').val();

	if (filter_order_id) {
		url += '&filter_order_id=' + encodeURIComponent(filter_order_id);
	}

	var filter_customer = $('input[name=\'filter_customer\']').val();

	if (filter_customer) {
		url += '&filter_customer=' + encodeURIComponent(filter_customer);
	}

	var filter_order_status = $('select[name=\'filter_order_status\']').val();

	if (filter_order_status != '*') {
		url += '&filter_order_status=' + encodeURIComponent(filter_order_status);
	}

	var filter_total = $('input[name=\'filter_total\']').val();

	if (filter_total) {
		url += '&filter_total=' + encodeURIComponent(filter_total);
	}

	var filter_date_added = $('input[name=\'filter_date_added\']').val();

	if (filter_date_added) {
		url += '&filter_date_added=' + encodeURIComponent(filter_date_added);
	}

	var filter_date_modified = $('input[name=\'filter_date_modified\']').val();

	if (filter_date_modified) {
		url += '&filter_date_modified=' + encodeURIComponent(filter_date_modified);
	}

	location = url;
});
//--></script> 
  <script type="text/javascript"><!--
$('input[name=\'filter_customer\']').autocomplete({
	'source': function(request, response) {
		$.ajax({
			url: 'index.php?route=customer/customer/autocomplete&token=<?php echo $token; ?>&filter_name=' +  encodeURIComponent(request),
			dataType: 'json',
			success: function(json) {
				response($.map(json, function(item) {
					return {
						label: item['name'],
						value: item['customer_id']
					}
				}));
			}
		});
	},
	'select': function(item) {
		$('input[name=\'filter_customer\']').val(item['label']);
	}
});
//--></script> 
  
  <script src="view/javascript/jquery/datetimepicker/bootstrap-datetimepicker.min.js" type="text/javascript"></script>
  <link href="view/javascript/jquery/datetimepicker/bootstrap-datetimepicker.min.css" type="text/css" rel="stylesheet" media="screen" />
  <script type="text/javascript"><!--
$('.date').datetimepicker({
	pickTime: false
});
//--></script></div>
<?php echo $footer; ?> 