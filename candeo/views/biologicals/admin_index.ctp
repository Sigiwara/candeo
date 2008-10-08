<h2>Biologicals <span class="count"><strong><?php echo $paginator->counter(array('format' => __('%count% ', true))); __('recorded')?></span></h2>
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
			<?php echo $html->link($biological['Biological']['name'], array('action'=>'view', $biological['Biological']['id']), array('title'=>'view this item'));?>
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
		<?php echo $html->link('Edit', array('action'=>'edit', $biological['Biological']['id']), array('class'=>'edit_item', 'title'=>'edit this item'));?>
		</td>
		<td>
			<?php echo $html->link('Delete', array('action'=>'delete', $biological['Biological']['id']), array('class'=>'delete_item', 'title'=>'delete this item'), 'Are you sure?')?>
		</td>
	</tr>
	<?php endforeach; ?>

</table>
<div id="page_nav" class="pagination">
	<?php echo $paginator->prev('« '.__('previous', true), array('class'=>'back prev'), null, array('class'=>'disabled prev'));?>
	<?php echo $paginator->numbers( array(null, '|'));?>
	<?php echo $paginator->next(__('next', true).' »', array('class'=>'back next'), null, array('class'=>'disabled next'));?>
</div>