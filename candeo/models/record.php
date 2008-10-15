<?php

class Record extends AppModel
{
	var $name = 'Record';
	var $belongsTo = array(
		'Institute'			=> array(
			'className'		=> 'Institute',
			'foreignKey'	=> 'institute_id'
			),
		'Field'			=> array(
			'className'		=> 'Field',
			'foreignKey'	=> 'field_id'
			),
		'Building'			=> array(
			'className'		=> 'Building',
			'foreignKey'	=> 'building_id'
			)
		);
}

?>