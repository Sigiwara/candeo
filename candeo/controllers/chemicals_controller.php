<?php

class ChemicalsController extends AppController
{
	var $name = 'Chemicals';
	var $paginate = array(
		'limit' => 50,
		'order' => array(
			'Chemical.id' => 'asc'
			)
		);
	function admin_index(){
		$this->set('chemicals', $this->paginate());
	}
	function admin_view($id = null){
		$this->Chemical->id = $id;
		$this->set('chemical', $this->Chemical->read());
		$this->pageTitle = 'View Chemical';
	}
	function data(){
		$this->layout = 'data';
		$this->set('chemicals', $this->Chemical->findAll());
	}
	function admin_add(){
		$this->set('chemicalClasses', $this->Chemical->ChemicalClass->find('list'));
		$this->set('chemicalPhrases', $this->Chemical->ChemicalPhrase->findNiceList());
		if (!empty($this->data)){
			if ($this->Chemical->save($this->data)){
				$this->flash('Your Chemical has been saved.','/admin/chemicals');
			}
		}
	}
	function admin_delete($id){
		$this->Chemical->del($id);
		$this->flash('The Chemical with id: '.$id.' has been deleted.', '/admin/chemicals');
	}
	function admin_edit($id = null){
		if (empty($this->data)){
			$this->Chemical->id = $id;
			$this->data = $this->Chemical->read();
			$this->set('chemicalClasses', $this->Chemical->ChemicalClass->find('list'));
			$this->set('chemicalPhrases', $this->Chemical->ChemicalPhrase->find('list'));
		}else{
			if ($this->Chemical->save($this->data)){
				$this->flash('Your Chemical has been updated.','/admin/chemicals');
			}
		}
	}
}

?>