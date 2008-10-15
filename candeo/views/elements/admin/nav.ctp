<ul>
	<li><?php echo $html->link('Institutes', array('controller'=>'institutes', 'action'=>'index', 'admin'=> true),  array('id'=>'Institutes')); ?></li>
	<li><?php echo $html->link('Records', array('controller'=>'records', 'admin'=> true),  array('id'=>'Records')); ?></li>
	<li class="secondary"><?php echo $html->link('Buildings', array('controller'=>'buildings', 'admin'=> true),  array('id'=>'Buildings')); ?></li>
	<li class="secondary"><?php echo $html->link('Fields', array('controller'=>'fields', 'admin'=> true),  array('id'=>'Fields')); ?></li>
	<li class="secondary"><?php echo $html->link('Phrases', array('controller'=>'phrases', 'admin'=> true),  array('id'=>'Phrases')); ?></li>
</ul>
<a href='#' id="ex_secondary">extend</a>
<a href='#' id="con_secondary">reduce</a>