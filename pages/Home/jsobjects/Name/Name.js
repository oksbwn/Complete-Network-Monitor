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
	}
}    