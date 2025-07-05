export default {
	Update (row) {
		update_device_name.run({
			deviceid: row.device_id,
			name: row.name
		}).then(() => {
			showAlert('Name updated successfully ✅', 'success');
			devices.run()
		}).catch((err) => {
			showAlert('Update failed ❌: ' + err.message, 'error');
		})
	},
	Remove(id){
		delete_device.run({
			device_id: id
		}).then(() => {
			devices.run();
			showAlert('Device removed successfully ✅', 'success');
			devices.run()
		}).catch((err) => {
			showAlert('Removal failed ❌: ' + err.message, 'error');
		})
	}
}    