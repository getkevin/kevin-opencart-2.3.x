<?php
/*
* 2020 kevin. payment  for OpenCart version 2.3.x.x 
* @version 1.0.1.3
*
* NOTICE OF LICENSE
*
* This source file is subject to the Academic Free License (AFL 3.0)
* that is bundled with this package in the file LICENSE.txt.
* It is also available through the world-wide-web at this URL:
* http://opensource.org/licenses/afl-3.0.php
* 
*  @author 2020 kevin. <help@kevin.eu>
*  @copyright kevin.
*  @license http://opensource.org/licenses/afl-3.0.php Academic Free License (AFL 3.0)
*/
define('KEVIN_VERSION', '1.0.1.3');
use Kevin\Client;
class ControllerExtensionPaymentKevin extends Controller {
	private $error = array(); 

	private $lib_version = '0.3'; 
	private $plugin_version = KEVIN_VERSION;
	
	public function install(){ 
		$this->load->model('extension/payment/kevin');
		$this->model_extension_payment_kevin->install();
	}
/*
	public function uninstall(){
		$this->load->model('extension/payment/kevin');
		$this->model_extension_payment_kevin->uninstall();
	}
*/	
	
	public function getProjectSettings() {
		require_once DIR_CATALOG . '/model/extension/payment/kevin/vendor/autoload.php';
		$clientId = !empty($this->config->get('kevin_client_id')) ? $this->config->get('kevin_client_id') : '';
		$clientSecret = !empty($this->config->get('kevin_client_secret')) ? $this->config->get('kevin_client_secret') : '';

		$options = [
			'error'                 => 'array',
			'version'               => $this->lib_version,
			'pluginVersion'         => strval(KEVIN_VERSION),
			'pluginPlatform'        => 'OpenCart',
			'pluginPlatformVersion' => strval(VERSION)
		];

		 try {
			 $kevinClient = new Client($clientId, $clientSecret, $options);
			 $projectSettings = $kevinClient->auth()->getProjectSettings();
		 } catch (\Kevin\KevinException $e) {
			 $project['empty'] = $e->GetMessage();
			 return $project;
		 }

		 return $projectSettings;
    }
	
	public function index() {
		$this->load->model('extension/payment/kevin');
        $this->load->language('extension/payment/kevin');

		$this->document->setTitle(strip_tags($this->language->get('heading_title')));
		$data['heading_title'] = $this->language->get('heading_title');

		$this->load->model('setting/setting');

		if (($this->request->server['REQUEST_METHOD'] == 'POST') && $this->validate()) {
			$this->model_setting_setting->editSetting('kevin', $this->request->post);				

			$this->session->data['success'] = $this->language->get('text_success');

			$this->response->redirect($this->url->link('extension/payment/kevin', 'token=' . $this->session->data['token'] . '&type=payment', true));
		}

		$project = 	$this->getProjectSettings()	;

		$data['error_client'] = '';

		if (empty($project['allowedRefundsFor']) && empty($project['paymentMethods'])) {
			if (!empty($project['error']['code'])) {
				$data['error_client'] = 'Can not connect to <span style="font-weight: 600; color:red;">kevin. </span> Error: ' . $project['error']['name'] . '.  Error code: ' . $project['error']['code'] . '. Make sure the credentials you entered are correct.';
			} else if (!empty($project['empty'])) {
				$data['error_client'] = $project['empty'];
			} else {
				$data['error_client'] = 'Can not connect to <span style="font-weight: 600; color:red;">kevin. </span> due to server error!';
			}
		} 
		
		if (!empty($project['allowedRefundsFor'])) {
			$data['refunds'] = ' Refunds is allowed.';
		} else {
			$data['refunds'] = '';
		}
		$data['payment_bank'] = '';
		$data['payment_card'] = '';
		$data['payment_methods'] = '';
		if (!empty($project['paymentMethods'])) {
			$data['payment_methods'] = true;
			foreach ($project['paymentMethods'] as $method) {
				if ($method == 'bank') {
					$data['payment_bank'] = ' Bank payment method is allowed.';
				}
				if ($method == 'card') {
					$data['payment_card'] = ' Card payment method is allowed.';
				}
			}
		} 
		
		if (!empty($project['isSandbox'])) {
			$data['text_sandbox_alert'] = '<span style="font-weight: 600; color:red;">kevin.</span> payment gateway is set to sandbox mode. For testing purposes only. Actual payments not available!';
		} else {
			$data['text_sandbox_alert'] = '';
		}

		//checking if kevin DB is updated on module update/reinstall.
		$DB_query = $this->model_extension_payment_kevin->checkKevinDB();
		
		if ($DB_query) {
			$this->model_extension_payment_kevin->install();
		}
		
		$this->document->setTitle(strip_tags($this->language->get('heading_title')));
		$texts = array(
			'heading_title',
			'text_payment',
			'text_edit',
			'text_extension',
			'text_success',
			'text_kevin',
			'text_right',
			'text_left',
			'text_disabled',
			'text_enabled',
			'text_all_zones',
			'text_select_action',
			'text_select_status',
			'text_confirm',
			'entry_general',
			'text_payment_log',
			'text_refund_log',
			'entry_order_statuses',
			'entry_instructions',
			'entry_client_id',
			'entry_client_secret',
			'entry_client_endpointSecret',
			'entry_client_company',
			'entry_client_iban',
			'entry_redirect_preferred',
			'entry_image',
			'entry_image_height',
			'entry_image_width',
			'entry_position',
			'entry_bank_name_enabled',
			'entry_kevin_title',
			'entry_instruction_title',
			'entry_kevin_instruction',
			'entry_total',
			'entry_order_status',
			'entry_started_status',
			'entry_completed_status',
			'entry_pending_status',
			'entry_failed_status',
			'entry_partial_refund_action',
			'entry_full_refund_action',
			'entry_refund_actions',
			'entry_created_refund_action',
			'entry_geo_zone',
			'entry_status',
			'entry_refund_status',
			'entry_partial_refund_status',
			'entry_refunded_status',
			'entry_log',
			'entry_payment_log',
			'entry_refund_log',
			'entry_sort_order',
			'button_download',
			'button_clear',
			'error_permission',
			'error_client_id',
			'error_client_secret',
			'error_client_endpointSecret',
			'error_client_company',
			'error_client_iban',
			'error_client_iban_valid',
			'error_title',
			'help_iban_format',
			'help_bank_name_enbl',
			'help_client_id',
			'help_client_secret',
			'help_client_endpointSecret',
			'help_bank_title',
			'help_total',
			'help_log',
			'help_width',
			'help_height',
			'help_position',
			'button_cancel',
			'button_save'
		);
		
		foreach ($texts as $text) {
			$data[$text] = $this->language->get($text);
		}

		$this->load->model('localisation/language');
		
		$languages = $this->model_localisation_language->getLanguages();

		foreach ($languages as $language) {
			if (isset($this->error['title' . $language['language_id']])) {
				$data['error_title' . $language['language_id']] = $this->error['title' . $language['language_id']];
			} else {
				$data['error_title' . $language['language_id']] = '';
			}
		}
		
		if (isset($this->session->data['error_log'])) {
			$data['error_warning'] = $this->session->data['error_log'];
		} else {
			$data['error_warning'] = '';
		}
		unset($this->session->data['error_log']);
			
		if (isset($this->session->data['success'])) {
			$data['success'] = $this->session->data['success'];
		} else {
			$data['success'] = '';
		}
		unset($this->session->data['success']);

		if (isset($this->error['warning'])) {
			$data['error_warning'] = $this->error['warning'];
		} else {
			$data['error_warning'] = '';
		}
		
		if (isset($this->error['bcmod'])) {
			$data['error_bcmod'] = $this->error['bcmod'];
		} else {
			$data['error_bcmod'] = '';
		}
	
		if (isset($this->error['client_id'])) {
			$data['error_client_id'] = $this->error['client_id'];
		} else {
			$data['error_client_id'] = '';
		}

		if (isset($this->error['client_secret'])) {
			$data['error_client_secret'] = $this->error['client_secret'];
		} else {
			$data['error_client_secret'] = '';
		}
		
		if (isset($this->error['client_endpointSecret'])) {
			$data['error_client_endpointSecret'] = $this->error['client_endpointSecret'];
		} else {
			$data['error_client_endpointSecret'] = '';
		}
		
		////
		if (isset($this->error['started_status'])) {
			$data['error_started_status'] = $this->error['started_status'];
		} else {
			$data['error_started_status'] = '';
		}
		
		if (isset($this->error['pending_status'])) {
			$data['error_pending_status'] = $this->error['pending_status'];
		} else {
			$data['error_pending_status'] = '';
		}
		
		if (isset($this->error['completed_status'])) {
			$data['error_completed_status'] = $this->error['completed_status'];
		} else {
			$data['error_completed_status'] = '';
		}
		
		if (isset($this->error['failed_status'])) {
			$data['error_failed_status'] = $this->error['failed_status'];
		} else {
			$data['error_failed_status'] = '';
		}
		
		if (isset($this->error['refunded_status'])) {
			$data['error_refunded_status'] = $this->error['refunded_status'];
		} else {
			$data['error_refunded_status'] = '';
		}
		
		if (isset($this->error['partial_status'])) {
			$data['error_partial_status'] = $this->error['partial_status'];
		} else {
			$data['error_partial_status'] = '';
		}
		
		if (isset($this->error['created_action'])) {
			$data['error_created_action'] = $this->error['created_action'];
		} else {
			$data['error_created_action'] = '';
		}
		
		if (isset($this->error['partial_action'])) {
			$data['error_partial_action'] = $this->error['partial_action'];
		} else {
			$data['error_partial_action'] = '';
		}
		
		if (isset($this->error['refunded_action'])) {
			$data['error_refunded_action'] = $this->error['refunded_action'];
		} else {
			$data['error_refunded_action'] = '';
		}
		
		
		//////
		
		if (isset($this->error['client_company'])) {
			$data['error_client_company'] = $this->error['client_company'];
		} else {
			$data['error_client_company'] = '';
		}
		
		if (isset($this->error['client_iban_empty'])) {
			$data['error_client_iban_empty'] = $this->error['client_iban_empty'];
		} else {
			$data['error_client_iban_empty'] = '';
		}
		
		if (isset($this->error['client_iban_valid'])) {
			$data['error_client_iban_valid'] = $this->error['client_iban_valid'];
		} else {
			$data['error_client_iban_valid'] = '';
		}
		
		$data['breadcrumbs'] = array();

		$data['breadcrumbs'][] = array(
			'text' => $this->language->get('text_home'),
			'href' => $this->url->link('common/dashboard', 'token=' . $this->session->data['token'], true)
		);

		$data['breadcrumbs'][] = array(
			'text' => $this->language->get('text_extension'),
			'href' => $this->url->link('extension/extension', 'token=' . $this->session->data['token'] . '&type=payment', true)
		);

		$data['breadcrumbs'][] = array(
			'text' => $this->language->get('heading_title'),
			'href' => $this->url->link('extension/payment/kevin', 'token=' . $this->session->data['token'], true)
		);

		$data['action'] = $this->url->link('extension/payment/kevin', 'token=' . $this->session->data['token'], true);

		$data['cancel'] = $this->url->link('extension/extension', 'token=' . $this->session->data['token'] . '&type=payment', true);

		if (isset($this->request->post['kevin_client_id'])) {
			$data['kevin_client_id'] = $this->request->post['kevin_client_id'];
		} else {
			$data['kevin_client_id'] = $this->config->get('kevin_client_id');
		}
		
		if (isset($this->request->post['kevin_client_secret'])) {
			$data['kevin_client_secret'] = $this->request->post['kevin_client_secret'];
		} else {
			$data['kevin_client_secret'] = $this->config->get('kevin_client_secret');
		}
		
		//endpointSecret
		if (isset($this->request->post['kevin_client_endpointSecret'])) {
			$data['kevin_client_endpointSecret'] = $this->request->post['kevin_client_endpointSecret'];
		} else {
			$data['kevin_client_endpointSecret'] = $this->config->get('kevin_client_endpointSecret');
		}
		
		if (isset($this->request->post['kevin_client_company'])) {
			$data['kevin_client_company'] = $this->request->post['kevin_client_company'];
		} else {
			$data['kevin_client_company'] = $this->config->get('kevin_client_company');
		}
		
		if (isset($this->request->post['kevin_client_iban'])) {
			$data['kevin_client_iban'] = $this->request->post['kevin_client_iban'];
		} else if (!empty($this->config->get('kevin_client_iban'))){
			$data['kevin_client_iban'] = $this->config->get('kevin_client_iban');
		} else {
			$data['kevin_client_iban'] = '';
		}
		
		if (isset($this->request->post['kevin_redirect_preferred'])) {
			$data['kevin_redirect_preferred'] = $this->request->post['kevin_redirect_preferred'];
		} else {
			$data['kevin_redirect_preferred'] = $this->config->get('kevin_redirect_preferred');
		}

		if (isset($this->request->post['kevin_total'])) {
			$data['kevin_total'] = $this->request->post['kevin_total'];
		} else {
			$data['kevin_total'] = $this->config->get('kevin_total'); 
		} 
		
		$this->load->model('localisation/language');
		
		$languages = $this->model_localisation_language->getLanguages();

		foreach ($languages as $language) {
			if (isset($this->request->post['kevin_title' . $language['language_id']])) {
				$data['kevin_title' . $language['language_id']] = $this->request->post['kevin_title' . $language['language_id']];
			} else {
				$data['kevin_title' . $language['language_id']] = $this->config->get('kevin_title' . $language['language_id']);
			} 	
		}
		
		// Image
		if (isset($this->request->post['kevin_image'])) {
			$data['kevin_image'] = $this->request->post['kevin_image'];
		} else {
			$data['kevin_image'] = $this->config->get('kevin_image');
		}
		
		if (isset($this->request->post['kevin_image_height'])) {
			$data['kevin_image_height'] = $this->request->post['kevin_image_height'];
		} else {
			$data['kevin_image_height'] = $this->config->get('kevin_image_height');
		}
		
		if (isset($this->request->post['kevin_image_width'])) {
			$data['kevin_image_width'] = $this->request->post['kevin_image_width'];
		} else {
			$data['kevin_image_width'] = $this->config->get('kevin_image_width');
		}

		$this->load->model('tool/image');
		
		$image_width = !empty($this->config->get('kevin_image_width')) ? $this->config->get('kevin_image_width') : 64;
		$image_height = !empty($this->config->get('kevin_image_height')) ? $this->config->get('kevin_image_height') : 64;

		if (!empty($this->config->get('kevin_image')) && is_file(DIR_IMAGE . $this->config->get('kevin_image'))) {
			$data['thumb'] = $this->model_tool_image->resize($this->config->get('kevin_image'), $image_width, $image_height);
		} else {
			$data['thumb'] = $this->model_tool_image->resize('no_image.png', 64, 64);
		}

		$data['placeholder'] = $this->model_tool_image->resize('no_image.png', 64, 64);
		
		if (isset($this->request->post['kevin_position'])) {
			$data['kevin_position'] = $this->request->post['kevin_position'];
		} else {
			$data['kevin_position'] = $this->config->get('kevin_position');
		}
		
		if (isset($this->request->post['kevin_bank_name_enabled'])) {
			$data['kevin_bank_name_enabled'] = $this->request->post['kevin_bank_name_enabled'];
		} else {
			$data['kevin_bank_name_enabled'] = $this->config->get('kevin_bank_name_enabled');
		}
		
		$data['languages'] = $languages;
		
		foreach ($languages as $language) {
			if (isset($this->request->post['kevin_ititle' . $language['language_id']])) {
				$data['kevin_ititle' . $language['language_id']] = $this->request->post['kevin_ititle' . $language['language_id']];
			} else {
				$data['kevin_ititle' . $language['language_id']] = $this->config->get('kevin_ititle' . $language['language_id']);
			} 	

			if (isset($this->request->post['kevin_instruction' . $language['language_id']])) {
				$data['kevin_instruction' . $language['language_id']] = $this->request->post['kevin_instruction' . $language['language_id']];
			} else {
				$data['kevin_instruction' . $language['language_id']] = $this->config->get('kevin_instruction' . $language['language_id']);
			} 
		}
		
		
		if (isset($this->request->post['kevin_geo_zone_id'])) {
			$data['kevin_geo_zone_id'] = $this->request->post['kevin_geo_zone_id'];
		} else {
			$data['kevin_geo_zone_id'] = $this->config->get('kevin_geo_zone_id'); 
		} 

		$this->load->model('localisation/geo_zone');

		$data['geo_zones'] = $this->model_localisation_geo_zone->getGeoZones();

		if (isset($this->request->post['kevin_status'])) {
			$data['kevin_status'] = $this->request->post['kevin_status'];
		} else {
			$data['kevin_status'] = $this->config->get('kevin_status');
		}
		
		if (isset($this->request->post['kevin_refund_status'])) {
			$data['kevin_refund_status'] = $this->request->post['kevin_refund_status'];
		} else {
			$data['kevin_refund_status'] = $this->config->get('kevin_refund_status');
		}
		
		if (isset($this->request->post['kevin_log'])) {
			$data['kevin_log'] = $this->request->post['kevin_log'];
		} else {
			$data['kevin_log'] = $this->config->get('kevin_log');
		}

       $this->load->model('localisation/geo_zone');

		$data['geo_zones'] = $this->model_localisation_geo_zone->getGeoZones();

		$this->load->model('localisation/order_status');

		$data['order_statuses'] = $this->model_localisation_order_status->getOrderStatuses();
		
		if (isset($this->request->post['kevin_started_status_id'])) {
			$data['kevin_started_status_id'] = $this->request->post['kevin_started_status_id'];
		} else {
			$data['kevin_started_status_id'] = $this->config->get('kevin_started_status_id');
		}

		if (isset($this->request->post['kevin_completed_status_id'])) {
			$data['kevin_completed_status_id'] = $this->request->post['kevin_completed_status_id'];
		} else {
			$data['kevin_completed_status_id'] = $this->config->get('kevin_completed_status_id');
		}
		
		if (isset($this->request->post['kevin_pending_status_id'])) {
			$data['kevin_pending_status_id'] = $this->request->post['kevin_pending_status_id'];
		} else {
			$data['kevin_pending_status_id'] = $this->config->get('kevin_pending_status_id');
		}

		if (isset($this->request->post['kevin_failed_status_id'])) {
			$data['kevin_failed_status_id'] = $this->request->post['kevin_failed_status_id'];
		} else {
			$data['kevin_failed_status_id'] = $this->config->get('kevin_failed_status_id');
		}
		
		if (isset($this->request->post['kevin_partial_refund_status_id'])) {
			$data['kevin_partial_refund_status_id'] = $this->request->post['kevin_partial_refund_status_id'];
		} else {
			$data['kevin_partial_refund_status_id'] = $this->config->get('kevin_partial_refund_status_id');
		}
		
		if (isset($this->request->post['kevin_refunded_status_id'])) {
			$data['kevin_refunded_status_id'] = $this->request->post['kevin_refunded_status_id'];
		} else {
			$data['kevin_refunded_status_id'] = $this->config->get('kevin_refunded_status_id');
		}

		if (isset($this->request->post['kevin_sort_order'])) {
			$data['kevin_sort_order'] = $this->request->post['kevin_sort_order'];
		} else {
			$data['kevin_sort_order'] = $this->config->get('kevin_sort_order');
		}
		
		$this->load->model('localisation/return_action');

		$data['refund_actions'] = $this->model_localisation_return_action->getReturnActions();
		
		if (isset($this->request->post['kevin_created_action_id'])) {
			$data['kevin_created_action_id'] = $this->request->post['kevin_created_action_id'];
		} else {
			$data['kevin_created_action_id'] = $this->config->get('kevin_created_action_id');
		}
		
		if (isset($this->request->post['kevin_partial_refund_action_id'])) {
			$data['kevin_partial_refund_action_id'] = $this->request->post['kevin_partial_refund_action_id'];
		} else {
			$data['kevin_partial_refund_action_id'] = $this->config->get('kevin_partial_refund_action_id');
		}
		
		if (isset($this->request->post['kevin_refunded_action_id'])) {
			$data['kevin_refunded_action_id'] = $this->request->post['kevin_refunded_action_id'];
		} else {
			$data['kevin_refunded_action_id'] = $this->config->get('kevin_refunded_action_id');
		}
		
		//refund log view
		$data['download_refund_log'] = $this->url->link('extension/payment/kevin/download_refund_log', 'token=' . $this->session->data['token'], true);
		$data['clear_refund_log'] = $this->url->link('extension/payment/kevin/clear_refund_log', 'token=' . $this->session->data['token'], true);

		$data['refund_log'] = '';
		
		$data['error_refund_log_warning'] = '';

		$file = DIR_LOGS . $this->config->get('config_kevin_refund_log') . 'kevin_refund.log';

		if (file_exists($file)) {
			$size = filesize($file);

			if ($size >= 5242880) {
				$suffix = array(
					'B',
					'KB',
					'MB',
					'GB',
					'TB',
					'PB',
					'EB',
					'ZB',
					'YB'
				);

				$i = 0;

				while (($size / 1024) > 1) {
					$size = $size / 1024;
					$i++;
				}

				$data['error_refund_log_warning'] = sprintf($this->language->get('error_payment_log_warning'), basename($file), round(substr($size, 0, strpos($size, '.') + 4), 2) . $suffix[$i]);
			} else {
				$data['refund_log'] = file_get_contents($file, FILE_USE_INCLUDE_PATH, null);
			}
		}
		
		//payment log view
		$data['download_payment_log'] = $this->url->link('extension/payment/kevin/download_payment_log', 'token=' . $this->session->data['token'], true);
		$data['clear_payment_log'] = $this->url->link('extension/payment/kevin/clear_payment_log', 'token=' . $this->session->data['token'], true);

		$data['payment_log'] = '';
		
		$data['error_payment_log_warning'] = '';

		$file = DIR_LOGS . $this->config->get('config_kevin_payment_log') . 'kevin_payment.log';

		if (file_exists($file)) {
			$size = filesize($file);

			if ($size >= 5242880) {
				$suffix = array(
					'B',
					'KB',
					'MB',
					'GB',
					'TB',
					'PB',
					'EB',
					'ZB',
					'YB'
				);

				$i = 0;

				while (($size / 1024) > 1) {
					$size = $size / 1024;
					$i++;
				}

				$data['error_payment_log_warning'] = sprintf($this->language->get('error_payment_log_warning'), basename($file), round(substr($size, 0, strpos($size, '.') + 4), 2) . $suffix[$i]);
			} else {
				$data['payment_log'] = file_get_contents($file, FILE_USE_INCLUDE_PATH, null);
			}
		}
		
		$data['header'] = $this->load->controller('common/header');
		$data['column_left'] = $this->load->controller('common/column_left');
		$data['footer'] = $this->load->controller('common/footer');

		$this->response->setOutput($this->load->view('extension/payment/kevin', $data));
	}
	
	public function download_refund_log() {
		$this->load->language('extension/payment/kevin');

		$file = DIR_LOGS . $this->config->get('config_kevin_refund_log') . 'kevin_refund.log';

		if (file_exists($file) && filesize($file) > 0) {
			$this->response->addheader('Pragma: public');
			$this->response->addheader('Expires: 0');
			$this->response->addheader('Content-Description: File Transfer');
			$this->response->addheader('Content-Type: application/octet-stream');
			$this->response->addheader('Content-Disposition: attachment; filename="' . $this->config->get('config_name') . '_' . date('Y-m-d_H-i-s', time()) . '_kevin_refund.log"');
			$this->response->addheader('Content-Transfer-Encoding: binary');

			$this->response->setOutput(file_get_contents($file, FILE_USE_INCLUDE_PATH, null));
		} else {
			$this->session->data['error_log'] = sprintf($this->language->get('error_refund_log_warning'), basename($file), '0B');

			$this->response->redirect($this->url->link('extension/payment/kevin', 'token=' . $this->session->data['token'], true));
		}
	}
	
	public function clear_refund_log() {
		$this->load->language('extension/payment/kevin');

		if (!$this->user->hasPermission('modify', 'extension/payment/kevin')) {
			$this->session->data['error_log'] = $this->language->get('error_permission');
		} else {
			$file = DIR_LOGS . $this->config->get('config_kevin_refund_log') . 'kevin_refund.log';


			$handle = fopen($file, 'w+');

			fclose($handle);

			$this->session->data['success'] = $this->language->get('text_clear_success');
		}

		$this->response->redirect($this->url->link('extension/payment/kevin', 'token=' . $this->session->data['token'], true));
	}
	
	public function download_payment_log() {
		$this->load->language('extension/payment/kevin');

		$file = DIR_LOGS . $this->config->get('config_kevin_payment_log') . 'kevin_payment.log';

		if (file_exists($file) && filesize($file) > 0) {
			$this->response->addheader('Pragma: public');
			$this->response->addheader('Expires: 0');
			$this->response->addheader('Content-Description: File Transfer');
			$this->response->addheader('Content-Type: application/octet-stream');
			$this->response->addheader('Content-Disposition: attachment; filename="' . $this->config->get('config_name') . '_' . date('Y-m-d_H-i-s', time()) . '_kevin_payment.log"');
			$this->response->addheader('Content-Transfer-Encoding: binary');

			$this->response->setOutput(file_get_contents($file, FILE_USE_INCLUDE_PATH, null));
		} else {
			$this->session->data['error_log'] = sprintf($this->language->get('kevin_warning'), basename($file), '0B');

			$this->response->redirect($this->url->link('extension/payment/kevin', 'token=' . $this->session->data['token'], true));
		}
	}
	
	public function clear_payment_log() {
		$this->load->language('extension/payment/kevin');

		if (!$this->user->hasPermission('modify', 'extension/payment/kevin')) {
			$this->session->data['error_log'] = $this->language->get('error_permission');
		} else {
			$file = DIR_LOGS . $this->config->get('config_kevin_payment_log') . 'kevin_payment.log';


			$handle = fopen($file, 'w+');

			fclose($handle);

			$this->session->data['success'] = $this->language->get('text_clear_success');
		}

		$this->response->redirect($this->url->link('extension/payment/kevin', 'token=' . $this->session->data['token'], true));
	}
	
	public function checkIBAN($iban) {
		if (preg_match('/[^A-Za-z0-9]/', $iban)) {
			return false;
		}
		
		if (!function_exists('bcmod')) {
			$error_bcmod = 'error_bcmod';
			return $error_bcmod;
		}
		
		$iban = strtolower(str_replace(' ','',$iban));
		$Countries = array('al'=>28,'ad'=>24,'at'=>20,'az'=>28,'bh'=>22,'be'=>16,'ba'=>20,'br'=>29,'bg'=>22,'cr'=>21,'hr'=>21,'cy'=>28,'cz'=>24,'dk'=>18,'do'=>28,'ee'=>20,'fo'=>18,'fi'=>18,'fr'=>27,'ge'=>22,'de'=>22,'gi'=>23,'gr'=>27,'gl'=>18,'gt'=>28,'hu'=>28,'is'=>26,'ie'=>22,'il'=>23,'it'=>27,'jo'=>30,'kz'=>20,'kw'=>30,'lv'=>21,'lb'=>28,'li'=>21,'lt'=>20,'lu'=>20,'mk'=>19,'mt'=>31,'mr'=>27,'mu'=>30,'mc'=>27,'md'=>24,'me'=>22,'nl'=>18,'no'=>15,'pk'=>24,'ps'=>29,'pl'=>28,'pt'=>25,'qa'=>29,'ro'=>24,'sm'=>27,'sa'=>24,'rs'=>22,'sk'=>24,'si'=>19,'es'=>24,'se'=>24,'ch'=>21,'tn'=>24,'tr'=>26,'ae'=>23,'gb'=>22,'vg'=>24);
		$Chars = array('a'=>10,'b'=>11,'c'=>12,'d'=>13,'e'=>14,'f'=>15,'g'=>16,'h'=>17,'i'=>18,'j'=>19,'k'=>20,'l'=>21,'m'=>22,'n'=>23,'o'=>24,'p'=>25,'q'=>26,'r'=>27,'s'=>28,'t'=>29,'u'=>30,'v'=>31,'w'=>32,'x'=>33,'y'=>34,'z'=>35);
		
		if (array_key_exists(substr($iban,0,2), $Countries) && strlen($iban) == $Countries[substr($iban,0,2)]) {

			$MovedChar = substr($iban, 4).substr($iban,0,4);
			$MovedCharArray = str_split($MovedChar);
			$NewString = "";

			foreach($MovedCharArray as $key => $value){
				if(!is_numeric($MovedCharArray[$key])){
					$MovedCharArray[$key] = $Chars[$MovedCharArray[$key]];
				}
				$NewString .= $MovedCharArray[$key];
			}
			if(bcmod($NewString, '97') == 1) {
				return true;
			}
		}
		return false;
	}

	protected function validate() {
		if (!$this->user->hasPermission('modify', 'extension/payment/kevin')) {
			$this->error['warning'] = $this->language->get('error_permission');
		}
		
		$this->load->model('localisation/language');

		$languages = $this->model_localisation_language->getLanguages();

		foreach ($languages as $language) {
			if (empty($this->request->post['kevin_title' . $language['language_id']]) && empty($this->request->post['kevin_image'])) {
				$this->error['title' . $language['language_id']] = $this->language->get('error_title');
			}
		}

		if (empty($this->request->post['kevin_client_id'])) {
			$this->error['client_id'] = $this->language->get('error_client_id');
		}

		if (empty($this->request->post['kevin_client_secret'])) {
			$this->error['client_secret'] = $this->language->get('error_client_secret');
		}
		
		if (empty($this->request->post['kevin_client_endpointSecret'])) {
			$this->error['client_endpointSecret'] = $this->language->get('error_client_endpointSecret');
		}
		
		if (empty($this->request->post['kevin_client_company'])) {
			$this->error['client_company'] = $this->language->get('error_client_company');
		}
		
		if (!empty($this->request->post['kevin_client_company']) && preg_match('/^[\w\s]+$/', $this->request->post['kevin_client_company']) == false) {
			$this->error['client_company'] = $this->language->get('error_client_c_symbol');
		}
		
		//order statuses
		if (empty($this->request->post['kevin_started_status_id'])) {
			$this->error['started_status'] = $this->language->get('error_started_status');
		}
		
		if (empty($this->request->post['kevin_pending_status_id'])) {
			$this->error['pending_status'] = $this->language->get('error_pending_status');
		}
		
		if (empty($this->request->post['kevin_completed_status_id'])) {
			$this->error['completed_status'] = $this->language->get('error_completed_status');
		}
		
		if (empty($this->request->post['kevin_failed_status_id'])) {
			$this->error['failed_status'] = $this->language->get('error_failed_status');
		}
		
		if (empty($this->request->post['kevin_refunded_status_id'])) {
			$this->error['refunded_status'] = $this->language->get('error_refunded_status');
		}
		
		if (empty($this->request->post['kevin_partial_refund_status_id'])) {
			$this->error['partial_status'] = $this->language->get('error_partial_status');
		}
		
		//refund actions
		if (empty($this->request->post['kevin_created_action_id'])) {
			$this->error['created_action'] = $this->language->get('error_created_action');
		}
		
		if (empty($this->request->post['kevin_partial_refund_action_id'])) {
			$this->error['partial_action'] = $this->language->get('error_partial_action');
		}
		
		if (empty($this->request->post['kevin_refunded_action_id'])) {
			$this->error['refunded_action'] = $this->language->get('error_refunded_action');
		}
		
	
		if (!empty($this->request->post['kevin_client_iban'])) {
			$validate = $this->checkIBAN($this->request->post['kevin_client_iban']);
			if (!$validate) {
				$this->error['client_iban_valid'] = $this->language->get('error_client_iban_valid');
			}
		}
		
		if (empty($this->request->post['kevin_client_iban'])) {
			$this->error['client_iban_empty'] = $this->language->get('error_client_iban_empty');
		}
		
		if (!empty($this->request->post['kevin_client_iban'])) {
			
			$validate = $this->checkIBAN($this->request->post['kevin_client_iban']);
			if (!$validate) {
				$this->error['client_iban_valid'] = $this->language->get('error_client_iban_valid');
			}
			if ($validate === 'error_bcmod') {
				$this->error['bcmod'] = $this->language->get('error_bcmod');
			}
		}
		
		if ($this->error && !isset($this->error['warning'])) {
			$this->error['warning'] = $this->language->get('error_warning');
		}
		
		return !$this->error;		

	
	}
}
