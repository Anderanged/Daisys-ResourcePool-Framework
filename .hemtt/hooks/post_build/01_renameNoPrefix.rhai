let addons = HEMTT_OUT.join("addons");
let prefix = HEMTT.project().prefix();
let prefix_len = prefix.len();

// prefix_component => component
for pbo_path in addons.list() {
    let pbo = pbo_path.file_name(); // grab name
    pbo.crop(prefix_len + 1); // remove prefix
    let new_path = addons.join(pbo);
    if !pbo_path.move(new_path) {
        fatal("Failed to move "+pbo+" into "+new_path);
    }
}