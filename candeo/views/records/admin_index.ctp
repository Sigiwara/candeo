<h2>Records <span class="count"><strong><?php echo $paginator->counter(array('format' => __('%count% ', true))); __('recorded')?></span></h2>
	<?php echo $html->link('Add', array('action'=>'add'), array('class'=>'edit')); ?>
<table>
	<tr>
		<th><?php echo $paginator->sort('Id', 'id'); ?></th>
		<th><?php echo $paginator->sort('Field', 'field'); ?></th>
		<th><?php echo $paginator->sort('Institute', 'institute_id'); ?></th>
		<th><?php echo $paginator->sort('Amount', 'amount'); ?></th>
		<th><?php echo $paginator->sort('Room', 'room'); ?></th>
		<th>Edit</th>
		<th>Delete</th>
	</tr>
	<?php foreach ($records as $record): ?>
	<tr>
		<td><?php echo $html->link($record['Record']['id'], array('action'=>'view', $record['Record']['id']), array('title'=>'view this item'));?></td>
		<td>
			<?php echo $html->link($record['Record']['field_id'], array('action'=>'view', $record['Record']['id']), array('title'=>'view this item'));?>
		</td>
		<td>
			<?php echo $html->link($record['Record']['institute_id'], array('controller'=>'institutes', 'action'=>'view', $record['Record']['institute_id']), array('title'=>'view this item'));?>
		</td>
		<td>
			<?php echo $record['Record']['amount']; ?>
		</td>
		<td>
			<?php echo $record['Record']['room']; ?>
		</td>
		<td>
		<?php echo $html->link('Edit', array('action'=>'edit', $record['Record']['id']), array('class'=>'edit_item', 'title'=>'edit this item'));?>
		</td>
		<td>
			<?php echo $html->link('Delete', array('action'=>'delete', $record['Record']['id']), array('class'=>'delete_item', 'title'=>'delete this item'), 'Are you sure?')?>
		</td>
	</tr>
	<?php endforeach; ?>

</table>
<div id="page_nav" class="pagination">
	<?php echo $paginator->prev('« '.__('previous', true), array('class'=>'back prev'), null, array('class'=>'disabled prev'));?>
	<?php echo $paginator->numbers( array(null, '|'));?>
	<?php echo $paginator->next(__('next', true).' »', array('class'=>'back next'), null, array('class'=>'disabled next'));?>
</div>