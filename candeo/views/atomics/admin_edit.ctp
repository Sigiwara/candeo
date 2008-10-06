<h2>Edit Atomic</h2>
	<?php echo $form->create('Atomic');?>
	<?php echo $form->hidden('Atomic/id'); ?>
<ul>
	<li>
		<?php echo $form->input('Atomic/name', array('class' => 'text'))?>
		<?php echo $form->error('Atomic/name', 'A name is required.') ?>
	</li>
	<li>
		<?php echo $form->input('Atomic/open', array('class' => 'checkbox'))?>
		<?php echo $form->error('Atomic/open', 'An opneness definition is required.') ?>
	</li>
	<li>
		<?php echo $form->input('Atomic/type', array('type'=>'radio', 'class' => 'radio', 'options' => array('Alpha' => 'Alpha', 'Beta' => 'Beta', 'Gamma' => 'Gamma', 'Neutronenstrahlung' => 'Neutronenstrahlung', 'Roentgenstrahlung' => 'Roentgenstrahlung')))?>
		<?php echo $form->error('Atomic/type', 'An inonic definition is required.') ?>
	</li>
</ul>
<div id="page_nav">
	<?php echo $form->end('Save')?>
	<?php echo $html->link('Cancel', '/admin/atomics', array('class' => 'back')); ?>
</div>