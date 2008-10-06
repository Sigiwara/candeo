<h2>Chemical Phrases</h2>
	<?php echo $html->link('Add', array('action'=>'add'), array('class'=>'edit')); ?>
<table>
	<tr>
		<th><?php echo $paginator->sort('Id', 'id'); ?></th>
		<th><?php echo $paginator->sort('Name', 'name'); ?></th>
		<th>Edit</th>
		<th>Delete</th>
	</tr>

	<?php foreach ($chemicalPhrases as $chemicalPhrase): ?>
	<tr>
		<td><?php echo $chemicalPhrase['ChemicalPhrase']['id']; ?></td>
		<td>
			<?php echo $html->link($chemicalPhrase['ChemicalPhrase']['phraseType'].' '.$chemicalPhrase['ChemicalPhrase']['phraseIndex'], "/chemicalPhrases/view/".$chemicalPhrase['ChemicalPhrase']['id']); ?>
		</td>
		<td>
		<?php echo $html->link('Edit', '/chemicalPhrases/edit/'.$chemicalPhrase['ChemicalPhrase']['id']);?>
		</td>
		<td>
			<?php echo $html->link('Delete', "/chemicalPhrases/delete/{$chemicalPhrase['ChemicalPhrase']['id']}", null, 'Are you sure?')?>
		</td>
	</tr>
	<?php endforeach; ?>

</table>
<div id="page_nav">
	<?php echo $html->link('Back', '/', array('class' => 'back')); ?>
</div>