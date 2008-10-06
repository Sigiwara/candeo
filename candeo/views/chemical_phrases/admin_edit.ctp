<h2>Edit Chemical Phrase</h2>
	<?php echo $form->create('ChemicalPhrase');?>
	<?php echo $form->hidden('ChemicalPhrase/id'); ?>
	<ul>
		<li class="radiofield">
			<?php echo $form->input('ChemicalPhrase/phraseType', array('type'=>'radio', 'class' => 'radio', 'options' => array('R' => 'R-Phrase', 'S' => 'S-Phrase')))?>
			<?php echo $form->error('ChemicalPhrase/phraseType', 'An phrase type definition is required.') ?>
		</li>
		<li>
			<?php echo $form->input('ChemicalPhrase/phraseIndex', array('class' => 'text'))?>
			<?php echo $form->error('ChemicalPhrase/phraseIndex', 'An index is required.') ?>
		</li>
		<li>
			<?php echo $form->input('ChemicalPhrase/phrase', array('class' => 'text'))?>
			<?php echo $form->error('ChemicalPhrase/phrase', 'A name is required.') ?>
		</li>
	</ul>
<div id="page_nav">
	<?php echo $form->end('Save')?>
	<?php echo $html->link('Cancel', '/chemicalPhrases', array('class' => 'back')); ?>
</div>