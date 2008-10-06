<h2><?php echo $atomic['Atomic']['name']?></h2>
	<?php echo $html->link('Edit', '/atomics/edit/'.$atomic['Atomic']['id'], array('class'=>'edit')); ?>
<dl>
	<dt>Open</dt><dd><?php echo $atomic['Atomic']['open']?></dd>
	<dt>Type</dt><dd><?php echo $atomic['Atomic']['type']?></dd>
</dl>
<div id="page_nav">
	<?php echo $html->link('Back', '/admin/atomics',  array('class'=>'back')); ?>
</div>