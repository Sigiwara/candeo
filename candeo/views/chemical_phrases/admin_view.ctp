<h2><?php echo $chemicalPhrase['ChemicalPhrase']['phraseType']?> <?php echo $chemicalPhrase['ChemicalPhrase']['phraseIndex']?></h2>
	<?php echo $html->link('Edit', '/chemicalPhrases/edit/'.$chemicalPhrase['ChemicalPhrase']['id'], array('class'=>'edit')); ?>
<dl>
	<dt>Phrase</dt><dd><?php echo $chemicalPhrase['ChemicalPhrase']['phrase']?></dd>
</dl>
<div id="page_nav">
	<?php echo $html->link('Back', '/chemicalPhrases',  array('class'=>'back')); ?>
</div>