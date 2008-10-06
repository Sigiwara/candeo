<?php

class ChemicalClass extends AppModel
{
	var $name = 'ChemicalClass';
	var $validate = array(
		'name'  => VALID_NOT_EMPTY
		);
	var $hasAndBelongsToMany = array(
		'Chemical' => array(
			'className'							=> 'Chemical',
			'joinTable'							=> 'chemical_classes_chemicals',
			'associationForeignKey'	=> 'chemical_id'
		)
	);
}

?>