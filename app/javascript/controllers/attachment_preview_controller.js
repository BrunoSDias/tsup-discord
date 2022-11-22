import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="attachment-preview"
export default class extends Controller {
  connect() {
  }

  showPreviewsContainer() {
    document.getElementById("attachments-previews-container").classList.remove("d-none")
  }

  hidePreviewsContainer() {
    document.getElementById("attachments-previews-container").classList.add("d-none")
  }

  clearPreviews() {
    document.getElementById("attachments-previews-container").innerHTML = ""
    this.hidePreviewsContainer();
  }

  removeFileFromFileList(index) {
    const dt = new DataTransfer()
    const input = document.getElementById('message_attachments')
    const { files } = input

    for (let i = 0; i < files.length; i++) {
      const file = files[i]
      if (index !== i)
        dt.items.add(file) 
    }
    
    input.files = dt.files
  }

  removePreview(event) {
    let preview = event.target.closest(".attachment__previews")
    this.removeFileFromFileList(parseInt(preview.getAttribute(('data-position'))));
    preview.remove();
    
    if(document.getElementById("attachments-previews-container").children.length == 0) {
      this.hidePreviewsContainer();
    }
  }

  removePreviewButton() {
    let icon = document.createElement("i")
    icon.classList.add("bi", "bi-trash-fill", "attachment__previews_remove_icon");
    icon.onclick = (e) => this.removePreview(e)
    return icon;
  }

  createAudioPreview(fileName) {
    let icon = document.createElement("i");
    const name = document.createElement("p");
    let element = document.createElement("div");

    icon.classList.add("bi", "bi-music-note", "attachment__previews_file_representation");
    name.textContent = fileName;
    name.classList.add("attachment__previews_filename");
    element.classList.add("attachment__previews", "attachment__previews_default");
    element.appendChild(icon);
    element.appendChild(name);
    element.appendChild(this.removePreviewButton());

    return element
  }

  createVideoPreview(fileName) {
    let icon = document.createElement("i");
    const name = document.createElement("p");
    let element = document.createElement("div");

    icon.classList.add("bi", "bi-camera-reels-fill", "attachment__previews_file_representation");
    name.textContent = fileName;
    name.classList.add("attachment__previews_filename");
    element.classList.add("attachment__previews", "attachment__previews_default");
    element.appendChild(icon);
    element.appendChild(name);
    element.appendChild(this.removePreviewButton());

    return element
  }

  createDefaultPreview(fileName) {
    let icon = document.createElement("i");
    const name = document.createElement("p");
    let element = document.createElement("div");

    icon.classList.add("bi", "bi-file-earmark-fill", "attachment__previews_file_representation");
    name.textContent = fileName;
    name.classList.add("attachment__previews_filename");
    element.classList.add("attachment__previews", "attachment__previews_default");
    element.appendChild(icon);
    element.appendChild(name);
    element.appendChild(this.removePreviewButton());

    return element
  }

  createImagePreview(reader, fileName) {
    const image = document.createElement("img")
    const name = document.createElement("p");
    const element = document.createElement("div")

    image.setAttribute("style", "background-image: url(" + reader.result + ");");
    name.textContent = fileName;
    name.classList.add("attachment__previews_filename")
    element.classList.add("attachment__previews", "attachment__previews_image");
    element.appendChild(image);
    element.appendChild(name);
    element.appendChild(this.removePreviewButton())

    return element
  }

  createPreviews(file, reader, i) {
    reader.onload = () => {
      let element;

      switch (file.type) {
        case "image/jpeg":
        case "image/png":
        case "image/gif":
          element = this.createImagePreview(reader, file.name)
          break;
        case "video/mp4":
        case "video/quicktime":
          element = this.createVideoPreview(file.name)
          break;
        case "audio/mp3":
        case "audio/mpeg":
        case "audio/wav":
        case "audio/ogg":
          element = this.createAudioPreview(file.name)
          break;
        default:
          element = this.createDefaultPreview(file.name)
      }

      element.setAttribute("data-position", i)
      document.getElementById("attachments-previews-container").appendChild(element);
    }
    reader.readAsDataURL(file);
  }

  preview() {
    this.clearPreviews();

    for (let i = 0; i < this.element.files.length; i++ ) {
      let file = this.element.files[i];
      const reader = new FileReader();

      this.createPreviews(file, reader, i)
    }

    this.showPreviewsContainer()
  }
}
