<?php

class Biological extends AppModel
{
	var $name = 'Biological';
	var $validate = array(
		'name'  => VALID_NOT_EMPTY
		);
	var $hasMany = 'Record';
}

?>