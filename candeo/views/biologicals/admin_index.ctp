<h2>Biologicals</h2>
	<?php echo $html->link('Add', array('action'=>'add'), array('class'=>'edit')); ?>
<table>
	<tr>
		<th><?php echo $paginator->sort('Id', 'id'); ?></th>
		<th><?php echo $paginator->sort('Name', 'name'); ?></th>
		<th><?php echo $paginator->sort('Activity', 'activity'); ?></th>
		<th><?php echo $paginator->sort('Security', 'security'); ?></th>
		<th><?php echo $paginator->sort('Openness', 'openness'); ?></th>
		<th>Edit</th>
		<th>Delete</th>
	</tr>

	<?php foreach ($biologicals as $biological): ?>
	<tr>
		<td><?php echo $biological['Biological']['id']; ?></td>
		<td>
			<?php echo $html->link($biological['Biological']['name'], "/biologicals/view/".$biological['Biological']['id']); ?>
		</td>
		<td>
			<?php echo $biological['Biological']['activity']; ?>
		</td>
		<td>
			<?php echo $biological['Biological']['group']; ?>
		</td>
		<td>
			<?php echo $biological['Biological']['security']; ?>
		</td>
		<td>
			<?php echo $biological['Biological']['openness']; ?>
		</td>
		<td>
		<?php echo $html->link('Edit', '/biologicals/edit/'.$biological['Biological']['id']);?>
		</td>
		<td>
			<?php echo $html->link('Delete', "/biologicals/delete/{$biological['Biological']['id']}", null, 'Are you sure?')?>
		</td>
	</tr>
	<?php endforeach; ?>

</table>
<div id="page_nav">
	<?php echo $html->link('Back', '/', array('class' => 'back')); ?>
</div>