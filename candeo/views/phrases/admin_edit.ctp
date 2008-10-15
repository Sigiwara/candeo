<h2>Edit Phrase</h2>
	<?php echo $form->create('Phrase');?>
	<?php echo $form->hidden('Phrase/id'); ?>
	<ul>
		<li class="radiofield">
			<?php echo $form->input('Phrase.phraseType', array('type'=>'radio', 'class' => 'radio', 'options' => array('R' => 'R-Phrase', 'S' => 'S-Phrase')))?>
			<?php echo $form->error('Phrase.phraseType', 'An phrase type definition is required.') ?>
		</li>
		<li>
			<?php echo $form->input('Phrase.phraseIndex', array('class' => 'text'))?>
			<?php echo $form->error('Phrase.phraseIndex', 'An index is required.') ?>
		</li>
		<li>
			<?php echo $form->input('Phrase.phrase', array('class' => 'text'))?>
			<?php echo $form->error('Phrase.phrase', 'A name is required.') ?>
		</li>
	</ul>
<div id="page_nav">
	<?php echo $form->end('Save')?>
	<?php echo $html->link('Cancel', '/phrase', array('class' => 'back')); ?>
</div>