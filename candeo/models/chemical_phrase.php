<?php

class ChemicalPhrase extends AppModel
{
	var $name = 'ChemicalPhrase';
	var $validate = array(
		'name'  => VALID_NOT_EMPTY
		);
	var $hasAndBelongsToMany = array(
		'Chemical' => array(
			'className'							=> 'Chemical',
			'joinTable'							=> 'chemical_phrases_chemicals',
			'associationForeignKey'	=> 'chemical_id'
		)
	);
	function findNiceList(){
		$res = $this->findAll(null, array('ChemicalPhrase.id', 'ChemicalPhrase.phraseType', 'ChemicalPhrase.phraseIndex') );
		$list = array();
		foreach($res as $row){
			$list[$row['ChemicalPhrase']['id']] = $row['ChemicalPhrase']['phraseType'] . ' ' . $row['ChemicalPhrase']['phraseIndex'];
		}
		return $list;
	}
}

?>