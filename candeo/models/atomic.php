<?php

class Atomic extends AppModel
{
	var $name = 'Atomic';
	var $validate = array(
		'name'  => VALID_NOT_EMPTY
		);
	var $hasMany = 'Record';
}

?>