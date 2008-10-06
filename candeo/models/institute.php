<?php

class Institute extends AppModel
{
	var $name = 'Institute';
	var $hasMany = array(
	'Record' => array(
		'className'		=> 'Record',
		'foreignKey'	=> 'institute_id',
		'dependent'		=> true
			)
		);
	var $validate = array(
		'name'  => VALID_NOT_EMPTY
		);
	var $hasAndBelongsToMany = array('Building' =>
		array('className'    => 'Building',
		'joinTable'    => 'buildings_institutes',
		'foreignKey'   => 'institute_id',
		'associationForeignKey'=> 'building_id',
		'conditions'   => '',
		'order'        => '',
		'limit'        => '',
		'unique'       => true,
		'finderQuery'  => '',
		'deleteQuery'  => '',
		)
	);
}

?>