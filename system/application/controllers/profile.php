<?php 
	class Profile extends Controller {
		
		public function index() {
			global $ide;
			$ide->goPrevious();
		}
		
		public function view($name) {
			global $ide;
			$this->load->model("profile_model", "profile");
			$data['profile'] = $this->profile->load($name);
			$data['name'] = $name;
			if(empty($data['profile'])) $ide->goPrevious();
			if(empty($data['profile'][0]['nickname'])) $ide->goPrevious();
			$data['friends'] = $this->profile->getFriends($data['profile'][0]['id']);
			$data['isFriend'] = ($ide->isLogged()) ?$this->profile->isFriend($data['profile'][0]['id'], $_SESSION['account_id']) : false;
			$data['videos'] = $this->profile->getVideos($data['profile'][0]['id']);
			$data['id'] = $data['profile'][0]['id'];
			$this->load->view("profile_view", $data);
		}
		
		
		public function update() {
			global $ide;
			$ide->requireLogin();
			$this->load->model("profile_model", "profile");
			$data['profile'] = $this->profile->load($_SESSION['account_id'], true);
			$this->load->helper("form_helper");
			if($_POST) {
				$this->load->library("form_validation");
				$this->form_validation->set_rules('rlname', 'Real Name', 'required|alpha_space');
				$this->form_validation->set_rules('location', 'Location', 'required|alpha_space');
				$this->form_validation->set_rules('about_me', 'About Me', 'required|max_length[350]');
				if($this->form_validation->run()) {
					$this->profile->update($_SESSION['account_id'], $_POST['rlname'], $_POST['location'], $_POST['about_me']);
					$ide->redirect(WEBSITE."/index.php/account/index/4");
				}
			}
			$this->load->view("profile_update", $data);
		}
		
		public function addFriend($id) {
			global $ide;
			$ide->requireLogin();
			$this->load->model("profile_model", "profile"); 
			if($id == $ide->loggedAccountId()) $ide->goPrevious();
			if(!$this->profile->exists($id)) $ide->goPrevious();
			if($this->profile->isFriend($id, $ide->loggedAccountId())) $ide->goPrevious();
			$this->profile->addFriend($id, $ide->loggedAccountId());
			success("Invitation has been sent, please wait till the user will accept.");
		}
		
		public function accept($id) {
			global $ide;
			$ide->requireLogin();
			$id = (int)$id;
			if(empty($id)) $ide->goPrevious();
			$this->load->model("profile_model", "profile");
			if(!$this->profile->pendingInvitationExists($id, $ide->loggedAccountId())) $ide->goPrevious();
			$this->profile->AcceptFriendship($id, $ide->loggedAccountId());
			success("Your friendship has been accepted.");
		}
		
		public function removeFriend($id) {
			global $ide;
			$ide->requireLogin();
			$this->load->model("profile_model", "profile");
			$this->profile->removeFriend($id, $ide->loggedAccountId());
			$ide->goPrevious();
		}
		
		public function community() {
			$this->load->model("profile_model", "profile");
			$data['videos'] = $this->profile->getLatestVideos();
			$data['comments'] = $this->profile->getLatestComments();
			$this->load->view("community", $data);
		}
	}
?>