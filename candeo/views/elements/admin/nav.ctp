<ul>
	<li><?php echo $html->link('Institutes', array('controller'=>'institutes', 'admin'=> true),  array('id'=>'Institutes')); ?></li>
	<li><?php echo $html->link('Buildings', array('controller'=>'buildings', 'admin'=> true),  array('id'=>'Buildings')); ?></li>
	<li><?php echo $html->link('Records', array('controller'=>'records', 'admin'=> true),  array('id'=>'Records')); ?></li>
	<li><?php echo $html->link('Atomics', array('controller'=>'atomics', 'admin'=> true),  array('id'=>'Atomics')); ?></li>
	<li><?php echo $html->link('Biologicals', array('controller'=>'biologicals', 'admin'=> true),  array('id'=>'Biologicals')); ?></li>
	<li><?php echo $html->link('Chemicals', array('controller'=>'chemicals', 'admin'=> true),  array('id'=>'Chemicals')); ?></li>
	<li><?php echo $html->link('Classes', array('controller'=>'chemicalClasses', 'admin'=> true),  array('id'=>'ChemicalClasses', 'class' => 'subnav')); ?></li>
	<li><?php echo $html->link('Phrases', array('controller'=>'chemicalPhrases', 'admin'=> true),  array('id'=>'ChemicalPhrases', 'class' => 'subnav')); ?></li>
</ul>