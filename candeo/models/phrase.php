<?php

class Phrase extends AppModel
{
	var $name = 'Phrase';
	var $validate = array(
		'name'  => VALID_NOT_EMPTY
		);
	var $hasAndBelongsToMany = array(
		'Field' => array(
			'className'							=> 'Field',
			'joinTable'							=> 'fields_phrases',
			'associationForeignKey'	=> 'field_id',
			'foreignKey'						=> 'phrase_id'
		)
	);
	function findNiceList(){
		$res = $this->findAll(null, array('Phrase.id', 'Phrase.phraseType', 'Phrase.phraseIndex') );
		$list = array();
		foreach($res as $row){
			$list[$row['Phrase']['id']] = $row['Phrase']['phraseType'] . ' ' . $row['Phrase']['phraseIndex'];
		}
		return $list;
	}
}

?>