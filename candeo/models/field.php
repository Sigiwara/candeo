<?php

class Field extends AppModel
{
	var $name = 'Field';
	var $validate = array(
		'name'		=> VALID_NOT_EMPTY
		);
	var $hasMany = array(
	'Record' => array(
		'className'		=> 'Record',
		'foreignKey'	=> 'field_id',
		'dependent'		=> true
			)
		);
	var $hasAndBelongsToMany = array(
		'Phrase' => array(
			'className'							=> 'Phrase',
			'joinTable'							=> 'fields_phrases',
			'associationForeignKey'	=> 'phrase_id',
			'foreignKey'						=> 'field_id'
		)
	);
}

?>