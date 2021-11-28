<?php echo $header; ?><?php echo $column_left; ?>
<div id="content">
  <div class="page-header">
    <div class="container-fluid">
      <div class="pull-right"><a href="<?php echo $cancel; ?>" data-toggle="tooltip" title="<?php echo $button_cancel; ?>" class="btn btn-default"><i class="fa fa-reply"></i></a></div>
      <h1><?php echo $heading_title; ?></h1>
      <ul class="breadcrumb">
        <?php foreach ($breadcrumbs as $breadcrumb) { ?> 
        <li><a href="<?php echo $breadcrumb['href']; ?>"><?php echo $breadcrumb['text']; ?></a></li>
        <?php } ?>
      </ul>
    </div>
  </div>
  <div class="container-fluid">
	  
    <div class="row">
      <div class="col-md-6">
        <div class="panel panel-default">
          <div class="panel-heading">
            <h3 class="panel-title"><i class="fa fa-shopping-cart"></i> <?php echo $text_order_detail; ?></h3>
          </div>
          <table class="table">
            <tbody>
              <tr>
                <td style="width: 1%;"><button data-toggle="tooltip" title="<?php echo $text_store; ?>" class="btn btn-info btn-xs"><i class="fa fa-shopping-cart fa-fw"></i></button></td>
                <td><a href="<?php echo $store_url; ?>" target="_blank"><?php echo $store_name; ?></a></td>
              </tr>
              <tr>
                <td><button data-toggle="tooltip" title="<?php echo $text_date_added; ?>" class="btn btn-info btn-xs"><i class="fa fa-calendar fa-fw"></i></button></td>
                <td><?php echo $date_added; ?></td>
              </tr>
              <tr>
                <td><button data-toggle="tooltip" title="<?php echo $text_payment_method; ?>" class="btn btn-info btn-xs"><i class="fa fa-credit-card fa-fw"></i></button></td>
                <td><?php echo $payment_method; ?></td>
              </tr>
              <?php if ($shipping_method) { ?> 
              <tr>
                <td><button data-toggle="tooltip" title="<?php echo $text_shipping_method; ?>" class="btn btn-info btn-xs"><i class="fa fa-truck fa-fw"></i></button></td>
                <td><?php echo $shipping_method; ?></td>
              </tr>
              <?php } ?>
            </tbody>
          </table>
        </div>
      </div>
      <div class="col-md-6">
        <div class="panel panel-default">
          <div class="panel-heading">
            <h3 class="panel-title"><i class="fa fa-user"></i> <?php echo $text_customer_detail; ?></h3>
          </div>
          <table class="table">
            <tr>
              <td style="width: 1%;"><button data-toggle="tooltip" title="<?php echo $text_customer; ?>" class="btn btn-info btn-xs"><i class="fa fa-user fa-fw"></i></button></td>
              <td><?php if ($customer) { ?> 
                <a href="<?php echo $customer; ?>" target="_blank"><?php echo $firstname; ?> <?php echo $lastname; ?></a>
                <?php } else { ?>
                <?php echo $firstname; ?> <?php echo $lastname; ?>
                <?php } ?></td>
            </tr>
            <tr>
              <td><button data-toggle="tooltip" title="<?php echo $text_customer_group; ?>" class="btn btn-info btn-xs"><i class="fa fa-group fa-fw"></i></button></td>
              <td><?php echo $customer_group; ?></td>
            </tr>
            <tr>
              <td><button data-toggle="tooltip" title="<?php echo $text_email; ?>" class="btn btn-info btn-xs"><i class="fa fa-envelope-o fa-fw"></i></button></td>
              <td><a href="mailto:<?php echo $email; ?>"><?php echo $email; ?></a></td>
            </tr>
            <tr>
              <td><button data-toggle="tooltip" title="<?php echo $text_telephone; ?>" class="btn btn-info btn-xs"><i class="fa fa-phone fa-fw"></i></button></td>
              <td><?php echo $telephone; ?></td>
            </tr>
          </table>
        </div>
      </div>
		<!-- -->
    </div>
	  
	  <?php if ($error_refund) { ?> 
    <div class="kevin-alert alert-danger"><i class="fa fa-exclamation-circle"></i> <?php echo $error_refund; ?>
      <button type="button" class="close" data-dismiss="alert">&times;</button>
    </div>
    <?php } ?>
	  <?php if ($error_client) { ?> 
    <div class="kevin-alert alert-danger"><i class="fa fa-exclamation-circle"></i> <?php echo $error_client; ?>
      <button type="button" class="close" data-dismiss="alert">&times;</button>
    </div>
    <?php } ?>

	<?php if ($success_refund) { ?>  
    <div class="kevin-alert alert-success"><i class="fa fa-exclamation-circle"></i> <?php echo $success_refund; ?>
      <button type="button" class="close" data-dismiss="alert">&times;</button>
    </div>
   <?php } ?>
	  
    <div class="panel panel-default">
      <div class="panel-heading">
        <h3 class="panel-title"><i class="fa fa-info-circle"></i> <?php echo $text_order; ?></h3>
      </div>
      <div class="panel-body">
        
        <table class="table table-bordered">
          <thead>
            <tr>
              <td class="text-left"><?php echo $column_product; ?></td>
              <td class="text-left"><?php echo $column_model; ?></td>
              <td class="text-right"><?php echo $column_quantity; ?></td>
              <td class="text-right"><?php echo $column_price; ?></td>
              <td class="text-right"><?php echo $column_total; ?></td>
            </tr>
          </thead>
          <tbody>
            <?php foreach ($products as $product) { ?> 
            <tr>
              <td class="text-left"><a href="<?php echo $product['href']; ?>"><?php echo $product['name']; ?></a>
                <?php foreach ($product['option'] as $option) { ?> 
                <br />
                <?php if ($option['type'] != 'file') { ?> 
                &nbsp;<small> - <?php echo $option['name']; ?>: <?php echo $option['value']; ?></small>
                <?php } else { ?>
                &nbsp;<small> - <?php echo $option['name']; ?>: <a href="<?php echo $option['href']; ?>"><?php echo $option['value']; ?></a></small>
                <?php } ?>
                <?php } ?></td>
              <td class="text-left"><?php echo $product['model']; ?></td>
              <td class="text-right"><?php echo $product['quantity']; ?></td>
              <td class="text-right"><?php echo $product['price']; ?></td>
              <td class="text-right"><?php echo $product['total']; ?></td>
            </tr>
            <?php } ?>
            <?php foreach ($vouchers as $voucher) { ?> 
            <tr>
              <td class="text-left"><a href="<?php echo $voucher['href']; ?>"><?php echo $voucher['description']; ?></a></td>
              <td class="text-left"></td>
              <td class="text-right">1</td>
              <td class="text-right"><?php echo $voucher['amount']; ?></td>
              <td class="text-right"><?php echo $voucher['amount']; ?></td>
            </tr>
            <?php } ?>
            <?php foreach ($totals as $total) { ?> 
            <tr>
              <td colspan="4" class="text-right"><?php echo $total['title']; ?></td>
              <td class="text-right"><?php echo $total['text']; ?></td>
            </tr>
            <?php } ?>
          </tbody>
        </table>

		  	  <!-- refund modal -->	
				<div class="modal fade" id="kevin-refund<?php echo $order_id; ?>" tabindex="-1" role="dialog" aria-labelledby="myModalLabel"
			  aria-hidden="true">
			  <div class="modal-dialog" role="document">
					  
				<div class="modal-content">
				  <div class="modal-header text-center">
					<h4 class="modal-title w-100 font-weight-bold"><?php echo $text_refund_order_id; ?> <?php echo $order_id; ?></h4>
					<button type="button" class="close kevin-refund-close" data-dismiss="modal" aria-label="Close">
					  <span aria-hidden="true">&times;</span>
					</button>
				  </div>
					<form method="post" action="<?php echo $refund_kevin; ?>" enctype="multipart/form-data" id="form-kevin-refund-<?php echo $order_id; ?>">
					<div class="modal-body">
						
						<div calss="product-grid" >
						<?php $product_row = 0; ?>
						<?php foreach ($refund_products as $product) { ?> 
					 <div class="form-refund qunqtity-danger<?php echo $product['product_id']; ?>">
						<label class="col-sm-6 control-label text-right refund-label" for="input-clientid"><?php echo $text_product_restock; ?><div style="font-weight: 700;"><?php echo $product['name']; ?></div></label>
						<div class="product-select col-sm-6">
						<label class="col-sm-2 control-label text-right refund-label " id="product-quantity<?php echo $product['product_id']; ?>" for="input-product-quantity<?php echo $product_row; ?>"><?php echo $text_Qty; ?></label>
						<div class="col-sm-6 refund-grid">
						
							<select  data-price="<?php echo $product['price']; ?>" data-product_id="<?php echo $product['product_id']; ?>" name="kevin_refund_restock[<?php echo $product['product_id']; ?>]" id="input-product-quantity<?php echo $product_row; ?>" class="form-control products-quantity restock-option<?php echo $product['product_id']; ?>" >
						<?php foreach ($product['quantities'] as $quantity) { ?> 		
                  		<option  value="<?php echo $quantity; ?>"><?php echo $quantity; ?></option>
						<?php } ?>		
                		</select>
							<input type="hidden" name="product_price" value="<?php echo $product['price']; ?>" id="product-price" class="form-control" />	
							</div> 
							
						</div>
					 </div>
							<?php $product_row++; ?>
						 <?php } ?>
						</div>
						
					  <div class="form-refund">
						<label class="col-sm-6 control-label text-right refund-label" for="input-refunded"><?php echo $text_refunded; ?></label>
						<div class="col-sm-6 refund-grid text-right refund-label">
						  <?php echo $amount; ?>

						</div>
					 </div>
						 
					  <div class="form-refund">
						<label class="col-sm-6 control-label  text-right refund-label" for="input-available"><?php echo $text_refund_available; ?></label>
						<div class="col-sm-6 refund-grid  text-right refund-label">
						  <?php echo $amount_available; ?>

						</div>
					 </div>
						
					 
					  <div class="form-refund">
						<label class="col-sm-6 control-label text-right refund-label" for="input-refund<?php echo $order_id; ?>"><?php echo $text_refund_amount; ?>&nbsp;<div style="font-weight: 700; color:red; float: right;">*</div></label>
						<div class="col-sm-6 refund-grid">
						  <input type="text" name="kevin_refund_amount" value="" placeholder="<?php echo $text_refund_amount; ?>" id="input-refund<?php echo $order_id; ?>" class="form-control input-refund" />

						</div>
					 </div>
						 
					  <div class="form-refund">
						<label class="col-sm-6 control-label text-right refund-label" for="input-reason"><?php echo $text_reason; ?></label>
						<div class="col-sm-6 refund-grid">
						  <input type="text" name="kevin_refund_reason" value="" placeholder="<?php echo $text_reason; ?>" id="input-reason" class="form-control" />

						</div>
					 </div> 
						
						<input type="hidden" name="payment_id" value="<?php echo $payment_id; ?>" id="payment-id" class="form-control" />

						</div>
					
					<script type="text/javascript"><!--
					
						$(document).ready(function(){
							$("#input-refund<?php echo $order_id; ?>").keyup(function(e){
								e.preventDefault();
								var input_value = $(this).val();
								input_value = input_value.replace(/,/g, '.')
								var currentText = parseFloat(input_value).toFixed(2);
								var symbol_left = "<?php echo $currency_symbol_left; ?>";
								var symbol_right = "<?php echo $currency_symbol_right; ?>";
								$("#refund-amount<?php echo $order_id; ?>").text(symbol_left + currentText + symbol_right);
								if (!currentText) {
									$("#refund-amount<?php echo $order_id; ?>").text(symbol_left + 0.00 + symbol_right);
								}
							});

							$('#kevin-refund-amount').on('click', function (e) {
								e.preventDefault();
								if($("#input-refund<?php echo $order_id; ?>").val() == ''){ 
									alert('<?php echo $text_refund_empty; ?>');
								} else {
									if (confirm('<?php echo $text_confirm_refund; ?>')) {
										$('#form-kevin-refund-<?php echo $order_id; ?>').submit();
									} else {
										return false;
									}
								}
							});
						});
					//--></script> 
				  <div class="modal-footer d-flex justify-content-center"> 
					<div class="checkbox notify-checkbox col-sm-6">
					<label class="control-label col-sm-5 text-right notify-label" for="input-notify"><?php echo $entry_notify; ?></label>
					<input type="checkbox" class="col-sm-1 text-right" id="input-notify" name="notify_refund" value="1" /> </div>
					 <button id="kevin-refund-amount" form="form-kevin-refund-<?php echo $order_id; ?>"  class="btn btn-primary kevin-refund-amount"><?php echo $text_refund; ?>&nbsp;<div id="refund-amount<?php echo $order_id; ?>"><?php echo $amount_0; ?></div></button>
					  
				  </div>
						 
					</form>	
				</div>
				  
			  </div>
			</div>
		  
		  	<div class="pull-right">
			<a href=""  class="btn btn-primary" data-toggle="modal" data-target="#kevin-refund<?php echo $order_id; ?>"><i data-toggle="tooltip" title="<?php echo $button_refund; ?>" class="fa fa-money"></i>&nbsp;<?php echo $text_create_refund; ?></a>
			</div>
		  <br /><br /><br />
        <?php if ($comment) { ?> 
        <table class="table table-bordered">
          <thead>
            <tr>
              <td><?php echo $text_comment; ?></td>
            </tr>
          </thead>
          <tbody>
            <tr>
              <td><?php echo $comment; ?></td>
            </tr>
          </tbody>
        </table>
		 				
		  
        <?php } ?>
      </div>
    </div>
	  

    <div class="panel panel-default">
      <div class="panel-heading">
        <h3 class="panel-title"><i class="fa fa-comment-o"></i> <?php echo $text_refund_history; ?></h3>
      </div>
      <div class="panel-body">

	<div class="table-responsive">
			   
		<table class="table table-bordered">
          <thead>
            <tr>
              <td style="width: 50%;" class="text-left"><?php echo $text_refund_available; ?></td>

              <td style="width: 50%;" class="text-left"><?php echo $text_refunded; ?></td>

            </tr>
          </thead>
          <tbody>
            <tr>
              <?php if ($amount_available) { ?> 
              <td class="text-left"><?php echo $amount_available; ?></td>
              <?php } ?>
				
              <?php if ($amount) { ?> 
              <td class="text-left"><?php echo $amount; ?></td>
              <?php } ?>
            </tr>
          </tbody>
			<!--restocked products-->
        </table>
			  <table class="table table-bordered table-hover">
              <thead>
				<tr>
                  <td class="text-left panel-heading" colspan="8"><?php echo $text_restocked_products; ?></td>
                </tr>
                <tr>
                  <td class="text-center"><?php echo $column_image; ?></td>
                  <td class="text-left"><?php echo $column_name; ?></td>
                  <td class="text-left"><?php echo $column_model; ?></td>
                  <td class="text-right"><?php echo $column_price; ?></td>
                  <td class="text-right"><?php echo $column_quantity; ?></td>
				  <td class="text-right"><?php echo $column_restocked_quantity; ?></td>
                  <td class="text-left"><?php echo $column_status; ?></td>
				  <td class="text-right"><?php echo $column_action; ?></td>
                </tr>
              </thead>
              <tbody>
                <?php if ($restocked_products) { ?> 
                <?php foreach ($restocked_products as $product) { ?> 
				  
                <tr>
                  <td class="text-center"><?php if ($product['image']) { ?> 
                    <img src="<?php echo $product['image']; ?>" alt="<?php echo $product['name']; ?>" class="img-thumbnail" />
                    <?php } else { ?>
                    <span class="img-thumbnail list"><i class="fa fa-camera fa-2x"></i></span>
                    <?php } ?></td>
                  <td class="text-left"><?php echo $product['name']; ?></td>
                  <td class="text-left"><?php echo $product['model']; ?></td>
                  <td class="text-right"><?php if ($product['special']) { ?> 
                    <span style="text-decoration: line-through;"><?php echo $product['price']; ?></span><br/>
                    <div class="text-danger"><?php echo $product['special']; ?></div>
                    <?php } else { ?>
                    <?php echo $product['price']; ?>
                    <?php } ?></td>
                  <td class="text-right"><?php if ($product['quantity'] <= 0) { ?> 
                    <span class="label label-warning"><?php echo $product['quantity']; ?></span>
                    <?php } else if ($product['quantity'] <= 5) { ?> 
                    <span class="label label-danger"><?php echo $product['quantity']; ?></span>
                    <?php } else { ?>
                    <span class="label label-success"><?php echo $product['quantity']; ?></span>
                    <?php } ?></td>
					<td class="text-right"><?php echo $product['restocked_quantity']; ?></td>
                  <td class="text-left"><?php echo $product['status']; ?></td>
					<td class="text-right"><a href="<?php echo $product['edit']; ?>" data-toggle="tooltip" title="<?php echo $button_edit; ?>" class="btn btn-primary"><i class="fa fa-pencil"></i></a></td>
                </tr>
                <?php } ?>
                <?php } else { ?>
                <tr>
                  <td class="text-center" colspan="8"><?php echo $text_no_results; ?></td>
                </tr>
                <?php } ?>
              </tbody>
            </table> 
			   
            <table class="table table-bordered table-hover">
              <thead>
                <tr>
                  <td class="text-left"><?php echo $column_refund_id; ?></td>	
				  <td class="text-right"><?php echo $column_amount_ready; ?></td>
				  <td class="text-right"><?php echo $column_refunded_amount; ?></td>
			      <td class="text-right"><?php echo $column_reason; ?></td> 
				  <td class="text-right"><?php echo $column_refund_status; ?></td>
                  <td class="text-left"><?php echo $column_date_added; ?></td>
                  <td class="text-left"><?php echo $column_date_modified; ?></td>
                </tr>
              </thead>
              <tbody>
                <?php if ($refunds) { ?> 
                <?php foreach ($refunds as $refund) { ?> 
                
                <tr> 
                  
                  <td class="text-right"><?php echo $refund['kevin_refund_id']; ?></td>

				  <td class="text-right"><?php echo $refund['amount']; ?></td>
				   <td class="text-right"><?php echo $refund['refunded_amount']; ?></td>
				  <td class="text-right"><?php echo $refund['reason']; ?></td>
				  <td class="text-right"><?php echo $refund['refund_status']; ?></td> 
                  <td class="text-left"><?php echo $refund['date_added']; ?></td>
                  <td class="text-left"><?php echo $refund['date_modified']; ?></td>

					
                </tr>
							
                <?php } ?>
                <?php } else { ?>
                <tr>
                  <td class="text-center" colspan="8"><?php echo $text_no_results; ?></td>
                </tr>
                <?php } ?>
              </tbody>
            </table>
			   
			   
			   
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
.kevin-alert {
    padding: 10px;
    margin-bottom: 17px;
    border: 1px solid transparent;
    border-radius: 3px;
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
	var product_row = <?php echo $product_row; ?>;
	var order_id = <?php echo $order_id; ?>;
for (i = 0; i <= product_row; i++) {	
	$("#input-product-quantity"+i).on('change', function (e) {
		e.preventDefault();
		var products = [];
		$('select.products-quantity').each(function(){
			var $this = $(this);
			products.push([ $this.data(), $this.val() ]);
		});
		//console.log(products);
		checkQuantity(products, order_id);
	});
}
	
var checkQuantity = function (products, order_id) {
	
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
			//$('#button').button('loading');
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
							//if (restock_quantiy === 0) {}
							$('.has-error').removeClass('has-error');
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

</div>
<?php echo $footer; ?> 
