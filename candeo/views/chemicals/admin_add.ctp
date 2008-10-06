<h2>Add Chemical</h2>
	<?php echo $form->create('Chemical')?>
<ul>
	<li>
		<?php echo $form->input('Chemical/name', array('class' => 'text'))?>
		<?php echo $form->error('Chemical/name', 'A name is required.') ?>
	</li>
	<li>
		<?php echo $form->input('ChemicalClass') ?>
	</li>
	<li>
		<?php echo $form->input('ChemicalPhrase') ?>
	</li>
</ul>
<div id="page_nav">
	<?php echo $form->end('Save')?>
	<?php echo $html->link('Cancel', '/chemicals', array('class' => 'back')); ?>
</div>