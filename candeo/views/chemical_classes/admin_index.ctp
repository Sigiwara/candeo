<h2>Chemical Classes</h2>
	<?php echo $html->link('Add', array('action'=>'add'), array('class'=>'edit')); ?>
<table>
	<tr>
		<th><?php echo $paginator->sort('Id', 'id'); ?></th>
		<th><?php echo $paginator->sort('Name', 'name'); ?></th>
		<th><?php echo $paginator->sort('Abbriviation', 'abbriviation'); ?></th>
		<th>Edit</th>
		<th>Delete</th>
	</tr>

	<?php foreach ($chemicalClasses as $chemicalClass): ?>
	<tr>
		<td><?php echo $chemicalClass['ChemicalClass']['id']; ?></td>
		<td>
			<?php echo $html->link($chemicalClass['ChemicalClass']['name'], "/chemicalClasses/view/".$chemicalClass['ChemicalClass']['id']); ?>
		</td>
		<td>
			<?php echo $chemicalClass['ChemicalClass']['abbriviation']; ?>
		</td>
		<td>
		<?php echo $html->link('Edit', '/chemicalClasses/edit/'.$chemicalClass['ChemicalClass']['id']);?>
		</td>
		<td>
			<?php echo $html->link('Delete', "/chemicalClasses/delete/{$chemicalClass['ChemicalClass']['id']}", null, 'Are you sure?')?>
		</td>
	</tr>
	<?php endforeach; ?>

</table>
<div id="page_nav">
	<?php echo $html->link('Back', '/', array('class' => 'back')); ?>
</div>