<?php

class ChemicalPhrasesController extends AppController
{
	var $name = 'ChemicalPhrases';
	var $paginate = array(
		'limit' => 50,
		'order' => array(
			'ChemicalPhrase.id' => 'asc'
			)
		);
	function admin_index(){
		$this->set('chemicalPhrases', $this->paginate());
	}
	function admin_view($id = null){
		$this->ChemicalPhrase->id = $id;
		$this->set('chemicalPhrase', $this->ChemicalPhrase->read());
		$this->pageTitle = 'View ChemicalPhrase';
	}
	function data(){
		$this->layout = 'data';
		$this->set('chemicalPhrases', $this->ChemicalPhrase->findAll());
	}
	function admin_add(){
		if (!empty($this->data)){
			if ($this->ChemicalPhrase->save($this->data)){
				$this->flash('Your ChemicalPhrase has been saved.','/admin/chemicalPhrases');
			}
		}
	}
	function admin_delete($id){
		$this->ChemicalPhrase->del($id);
		$this->flash('The ChemicalPhrase with id: '.$id.' has been deleted.', '/admin/chemicalPhrases');
	}
	function admin_edit($id = null){
		if (empty($this->data)){
			$this->ChemicalPhrase->id = $id;
			$this->data = $this->ChemicalPhrase->read();
		}else{
			if ($this->ChemicalPhrase->save($this->data['ChemicalPhrase'])){
				$this->flash('Your ChemicalPhrase has been updated.','/admin/chemicalPhrases');
			}
		}
	}
}

?>