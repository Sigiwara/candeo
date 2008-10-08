<h2>Chemical Classes <span class="count"><strong><?php echo $paginator->counter(array('format' => __('%count% ', true))); __('recorded')?></span></h2>
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
			<?php echo $html->link($chemicalClass['ChemicalClass']['name'], array('action'=>'view', $chemicalClass['ChemicalClass']['id']), array('title'=>'view this item'));?>
		</td>
		<td>
			<?php echo $chemicalClass['ChemicalClass']['abbriviation']; ?>
		</td>
		<td>
		<?php echo $html->link('Edit', array('action'=>'edit', $chemicalClass['ChemicalClass']['id']), array('class'=>'edit_item', 'title'=>'edit this item'));?>
		</td>
		<td>
			<?php echo $html->link('Delete', array('action'=>'delete', $chemicalClass['ChemicalClass']['id']), array('class'=>'delete_item', 'title'=>'delete this item'), 'Are you sure?')?>
		</td>
	</tr>
	<?php endforeach; ?>

</table>
<div id="page_nav" class="pagination">
	<?php echo $paginator->prev('« '.__('previous', true), array('class'=>'back prev'), null, array('class'=>'disabled prev'));?>
	<?php echo $paginator->numbers( array(null, '|'));?>
	<?php echo $paginator->next(__('next', true).' »', array('class'=>'back next'), null, array('class'=>'disabled next'));?>
</div>