<h2>Records <span class="count"><strong><?php echo count($records)."</strong> recorded"?></span></h2>
	<?php echo $html->link('Add', array('action'=>'add'), array('class'=>'edit')); ?>
<table>
	<tr>
		<th><?php echo $paginator->sort('Id', 'id'); ?></th>
		<th><?php echo $paginator->sort('Name', 'name'); ?></th>
		<th><?php echo $paginator->sort('Institute', 'institute_id'); ?></th>
		<th><?php echo $paginator->sort('Version', 'version'); ?></th>
		<th><?php echo $paginator->sort('Source Type', 'source_type'); ?></th>
		<th>Source</th>
		<th><?php echo $paginator->sort('Amount', 'amount'); ?></th>
		<th><?php echo $paginator->sort('Room', 'room'); ?></th>
		<th><?php echo $paginator->sort('Floor', 'floor'); ?></th>
		<th>Edit</th>
		<th>Delete</th>
	</tr>
	<?php foreach ($records as $record): ?>
	<tr>
		<td><?php echo $record['Record']['id']; ?></td>
		<td>
			<?php echo $html->link($record['Record']['name'], "/records/view/".$record['Record']['id']); ?>
		</td>
		<td>
			<?php echo $html->link($record['Record']['institute_id'], "/institutes/view/".$record['Record']['institute_id']); ?>
		</td>
		<td>
			<?php echo $record['Record']['version']; ?>
		</td>
		<td>
			<?php echo $html->link($record['Record']['source_type'], "/".$record['Record']['source_type']."s"); ?>
		</td>
		<td>
			<?php
			switch($record['Record']['source_type']){
				case 'Atomic':
					echo $html->link($record['Record']['atomic_id'], "/".$record['Record']['source_type']."s/view/".$record['Record']['atomic_id']);
					break;
				case 'Biological':
					echo $html->link($record['Record']['biological_id'], "/".$record['Record']['source_type']."s/view/".$record['Record']['biological_id']);
					break;
				case 'Chemical':
					echo $html->link($record['Record']['chemical_id'], "/".$record['Record']['source_type']."s/view/".$record['Record']['chemical_id']);
					break;
				default:
					break;
			}
			?>
		</td>
		<td>
			<?php echo $record['Record']['amount']; ?>
		</td>
		<td>
			<?php echo $record['Record']['room']; ?>
		</td>
		<td>
			<?php echo $record['Record']['floor']; ?>
		</td>
		<td>
		<?php echo $html->link('Edit', '/records/edit/'.$record['Record']['id']);?>
		</td>
		<td>
			<?php echo $html->link('Delete', "/records/delete/{$record['Record']['id']}", null, 'Are you sure?')?>
		</td>
	</tr>
	<?php endforeach; ?>

</table>
<div id="page_nav">
	<?php echo $html->link('Back', array('controller'=>'pages', 'action'=>'home', 'admin'=>false), array('class'=>'back')); ?>
</div>