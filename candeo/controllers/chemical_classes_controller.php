<?php

class ChemicalClassesController extends AppController
{
	var $name = 'ChemicalClasses';
	var $paginate = array(
		'limit' => 50,
		'order' => array(
			'ChemicalClass.id' => 'asc'
			)
		);
	function admin_index(){
		$this->set('chemicalClasses', $this->paginate());
	}
	function admin_view($id = null){
		$this->ChemicalClass->id = $id;
		$this->set('chemicalClass', $this->ChemicalClass->read());
		$this->pageTitle = 'View ChemicalClass';
	}
	function data(){
		$this->layout = 'data';
		$this->set('chemicalClasses', $this->ChemicalClass->findAll());
	}
	function admin_add(){
		if (!empty($this->data)){
			if ($this->ChemicalClass->save($this->data)){
				$this->flash('Your ChemicalClass has been saved.','/admin/chemicalClasses');
			}
		}
	}
	function admin_delete($id){
		$this->ChemicalClass->del($id);
		$this->flash('The ChemicalClass with id: '.$id.' has been deleted.', '/admin/chemicalClasses');
	}
	function admin_edit($id = null){
		if (empty($this->data)){
			$this->ChemicalClass->id = $id;
			$this->data = $this->ChemicalClass->read();
		}else{
			if ($this->ChemicalClass->save($this->data['ChemicalClass'])){
				$this->flash('Your ChemicalClass has been updated.','/admin/chemicalClasses');
			}
		}
	}
}

?>