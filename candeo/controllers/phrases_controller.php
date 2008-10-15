<?php

class PhrasesController extends AppController
{
	var $name = 'Phrases';
	var $paginate = array(
		'limit' => 50
		);
	function admin_index(){
		$this->set('phrases', $this->paginate());
	}
	function admin_view($id = null){
		$this->Phrase->id = $id;
		$this->set('phrase', $this->Phrase->read());
		$this->pageTitle = 'View Phrase';
	}
	function data(){
		$this->layout = 'data';
		$this->set('phrase', $this->Phrase->findAll());
	}
	function admin_add(){
		if (!empty($this->data)){
			if ($this->Phrase->save($this->data)){
				$this->flash('Your Phrase has been saved.','/admin/phrases');
			}
		}
	}
	function admin_delete($id){
		$this->Phrase->del($id);
		$this->flash('The Phrase with id: '.$id.' has been deleted.', '/admin/phrases');
	}
	function admin_edit($id = null){
		if (empty($this->data)){
			$this->Phrase->id = $id;
			$this->data = $this->Phrase->read();
		}else{
			if ($this->Phrase->save($this->data['Phrase'])){
				$this->flash('Your Phrases has been updated.','/admin/phrases');
			}
		}
	}
}

?>