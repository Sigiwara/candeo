<?php

class Building extends AppModel
{
	var $name = 'Building';
	var $validate = array(
		'name'		=> VALID_NOT_EMPTY
		);
	var $hasMany = array(
	'Record' => array(
		'className'		=> 'Record',
		'foreignKey'	=> 'building_id',
		'dependent'		=> true
			)
		);
	var $hasAndBelongsToMany = array('Institute' =>
		array('className'    => 'Institute',
		'joinTable'    => 'buildings_institutes',
		'foreignKey'   => 'building_id',
		'associationForeignKey'=> 'institute_id',
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