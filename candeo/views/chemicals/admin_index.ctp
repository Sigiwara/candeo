<h2>Chemicals</h2>
	<?php echo $html->link('Add', array('action'=>'add'), array('class'=>'edit')); ?>
<table>
	<tr>
		<th><?php echo $paginator->sort('Id', 'id'); ?></th>
		<th><?php echo $paginator->sort('Name', 'name'); ?></th>
		<th>Edit</th>
		<th>Delete</th>
	</tr>

	<?php foreach ($chemicals as $chemical): ?>
	<tr>
		<td><?php echo $chemical['Chemical']['id']; ?></td>
		<td>
			<?php echo $html->link($chemical['Chemical']['name'], "/chemicals/view/".$chemical['Chemical']['id']); ?>
		</td>
		<td>
		<?php echo $html->link('Edit', '/chemicals/edit/'.$chemical['Chemical']['id']);?>
		</td>
		<td>
			<?php echo $html->link('Delete', "/chemicals/delete/{$chemical['Chemical']['id']}", null, 'Are you sure?')?>
		</td>
	</tr>
	<?php endforeach; ?>

</table>
<div id="page_nav">
	<?php echo $html->link('Back', '/', array('class' => 'back')); ?>
</div>