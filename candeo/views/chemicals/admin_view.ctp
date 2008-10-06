<h2><?php echo $chemical['Chemical']['name']?></h2>
	<?php echo $html->link('Edit', '/chemicals/edit/'.$chemical['Chemical']['id'], array('class'=>'edit')); ?>
<dl>
	<dt>Classes</dt>
	<?php
		foreach ( $chemical['ChemicalClass'] as $chemicalclass) {
			echo '<dd>'.$chemicalclass['name'].'</dd>';
		}
	?>
	<dt>Phrases</dt>
	<?php
		foreach ( $chemical['ChemicalPhrase'] as $chemicalphrase) {
			echo '<dd><strong>'.$chemicalphrase['phraseType'].$chemicalphrase['phraseIndex'].'</strong> '.$chemicalphrase['phrase'].'</dd>';
		}
	?>
</dl>
<div id="page_nav">
	<?php echo $html->link('Back', '/chemicals',  array('class'=>'back')); ?>
</div>