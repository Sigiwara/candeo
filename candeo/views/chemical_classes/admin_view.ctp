<h2><?php echo $chemicalClass['ChemicalClass']['name']?></h2>
	<?php echo $html->link('Edit', '/chemicalClasses/edit/'.$chemicalClass['ChemicalClass']['id'], array('class'=>'edit')); ?>
<dl>
	<dt>Abbriviation</dt><dd><?php echo $chemicalClass['ChemicalClass']['abbriviation']?></dd>
	<dt>Criteria</dt><dd><?php echo $chemicalClass['ChemicalClass']['criteria']?></dd>
	<dt>Precaution</dt><dd><?php echo $chemicalClass['ChemicalClass']['precaution']?></dd>
</dl>
<div id="page_nav">
	<?php echo $html->link('Back', '/chemicalClasses',  array('class'=>'back')); ?>
</div>