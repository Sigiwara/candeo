<?php

class Record extends AppModel
{
	var $name = 'Record';
	var $validate = array(
		'name'  => VALID_NOT_EMPTY
	);
	var $belongsTo = array(
		'Institute'			=> array(
			'className'		=> 'Institute',
			'foreignKey'	=> 'institute_id'
			),
		'Building'			=> array(
			'className'		=> 'Building',
			'foreignKey'	=> 'building_id'
			),
		'Atomic'			=> array(
			'className'		=> 'Atomic',
			'foreignKey'	=> 'atomic_id'
			),
		'Biological'		=> array(
			'className'		=> 'Biological',
			'foreignKey'	=> 'biological_id'
			),
		'Chemical'			=> array(
			'className'		=> 'Chemical',
			'foreignKey'	=> 'chemical_id'
			)
		);
	function beforeSave(){
		switch($this->data['Record']['source_type']){
			case 'Atomic':
				$this->data['Record']['biological_id'] = null;
				$this->data['Record']['chemical_id'] = null;
				break;
			case 'Biological':
				$this->data['Record']['atomic_id'] = null;
				$this->data['Record']['chemical_id'] = null;
				break;
			case 'Chemical':
				$this->data['Record']['atomic_id'] = null;
				$this->data['Record']['biological_id'] = null;
				break;
			default:
				break;
		}
		return true;
	}
}

?>