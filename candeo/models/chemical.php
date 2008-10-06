<?php

class Chemical extends AppModel
{
	var $name = 'Chemical';
	var $validate = array(
		'name'  => VALID_NOT_EMPTY
		);
	var $hasMany = 'Record';
	var $hasAndBelongsToMany = array(
		'ChemicalClass' => array(
			'className'							=> 'ChemicalClass',
			'joinTable'							=> 'chemical_classes_chemicals',
			'associationForeignKey'	=> 'chemical_class_id'
		),
		'ChemicalPhrase'	=> array(
			'className'							=> 'ChemicalPhrase',
			'joinTable'							=> 'chemical_phrases_chemicals',
			'associationForeignKey'	=> 'chemical_phrase_id'
		)
	);
}

?>