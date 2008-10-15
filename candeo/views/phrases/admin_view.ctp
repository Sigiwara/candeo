<h2><?php echo $phrase['Phrase']['phraseType']?> <?php echo $phrase['Phrase']['phraseIndex']?></h2>
	<?php echo $html->link('Edit', '/phrases/edit/'.$phrase['Phrase']['id'], array('class'=>'edit')); ?>
<dl>
	<dt>Phrase</dt><dd><?php echo $phrase['Phrase']['phrase']?></dd>
</dl>
<div id="page_nav">
	<?php echo $html->link('Back', '/chemicalPhrases',  array('class'=>'back')); ?>
</div>