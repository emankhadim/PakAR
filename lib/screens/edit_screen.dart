import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:untitled/models/products.dart';
import 'package:untitled/providers/product_provider.dart';

class EditProductScreen extends StatefulWidget {
  static const routeName = '/edit';
  const EditProductScreen({Key? key}) : super(key: key);

  @override
  _EditProductScreenState createState() => _EditProductScreenState();
}

class _EditProductScreenState extends State<EditProductScreen> {
  final _pricefocusnode = FocusNode();
  final _descriptionfocusnode = FocusNode();
  final _iamgecontroller = TextEditingController();
  final _imagefocusnode = FocusNode();
  final _formsave = GlobalKey<FormState>();
  var _editedProduct =
      Products(id: '', title: '', description: '', price: 0, imageurl: '');
  var _isInit = true;
  var _initvalues = {
    'title': '',
    'description': '',
    'price': '',
    'imageurl': '',
  };
  var _isloading = false;

  @override
  void initState() {
    _imagefocusnode.addListener((_updateimgUrl));
    super.initState();
  }

  void _updateimgUrl() {
    if (!_imagefocusnode.hasFocus) {
      setState(() {});
    }
  }

  @override
  void didChangeDependencies() {
    if (_isInit) {
      final productid = ModalRoute.of(context)!.settings.arguments;
      // ?? ModalRoute
      // .of(context)!
      // .settings
      // .arguments as String;
      if (productid != '') {
        _editedProduct = Provider.of<ProductProvider>(context, listen: false)
            .findById(productid.toString());
        _initvalues = {
          'title': _editedProduct.title,
          'description': _editedProduct.description,
          'price': _editedProduct.price.toString(),
          'imageurl': '',
        };
        _iamgecontroller.text = _editedProduct.imageurl;
      }
      _isInit = false;
    }
    super.didChangeDependencies();
  }

  void dispose() {
    _imagefocusnode.removeListener((_updateimgUrl));
    _pricefocusnode.dispose();
    _descriptionfocusnode.dispose();
    _iamgecontroller.dispose();
    super.dispose();
  }

  Future<void> _saveform() async {
    final isvalidate = _formsave.currentState!.validate();
    if (!isvalidate) {
      return;
    }
    _formsave.currentState!.save();
    setState(() {
      _isloading = true;
    });
    if (_editedProduct.id != '') {
      await Provider.of<ProductProvider>(context, listen: false)
          .updateproduct(_editedProduct.id, _editedProduct);
    } else {
      try {
        await Provider.of<ProductProvider>(context, listen: false)
            .addProduct(_editedProduct);
      } catch (error) {
        await showDialog(
            context: context,
            builder: (ctx) => AlertDialog(
                  title: Text('Error'),
                  content: Text('Something went wrong'),
                  actions: [
                    TextButton(
                      onPressed: () => Navigator.of(ctx).pop(),
                      child: Text('OK'),
                    ),
                  ],
                ));
        Navigator.of(context).pop();
        // }finally{
        //   setState(() {
        //     _isloading=false;
        //   });
        //   Navigator.of(context).pop();
        // }
        Navigator.of(context).pop();
        setState(() {
          _isloading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Products'),
        actions: [IconButton(onPressed: _saveform, icon: Icon(Icons.save))],
      ),
      body: _isloading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : Padding(
              padding: const EdgeInsets.all(8.0),
              child: Form(
                key: _formsave,
                child: ListView(
                  children: [
                    TextFormField(
                      decoration: InputDecoration(
                        labelText: 'Title',
                      ),
                      initialValue: _initvalues['title'],
                      textInputAction: TextInputAction.next,
                      onFieldSubmitted: (_) {
                        FocusScope.of(context).requestFocus(_pricefocusnode);
                      },
                      onSaved: (value) {
                        _editedProduct = Products(
                            isFavorite: _editedProduct.isFavorite,
                            id: _editedProduct.id,
                            title: value.toString(),
                            description: _editedProduct.description,
                            price: _editedProduct.price,
                            imageurl: _editedProduct.imageurl);
                      },
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please Provide a value';
                        }
                        return null;
                      },
                    ),
                    TextFormField(
                      decoration: InputDecoration(
                        labelText: 'Price',
                      ),
                      initialValue: _initvalues['price'],
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please enter a price';
                        }
                        if (double.tryParse(value) == null) {
                          return 'Please enter a valid number';
                        }
                        if (double.parse(value) <= 0) {
                          return 'Please enter a number greater than 0';
                        }
                        return null;
                      },
                      textInputAction: TextInputAction.next,
                      keyboardType: TextInputType.number,
                      focusNode: _pricefocusnode,
                      onFieldSubmitted: (_) {
                        FocusScope.of(context)
                            .requestFocus(_descriptionfocusnode);
                      },
                      onSaved: (value) {
                        _editedProduct = Products(
                            isFavorite: _editedProduct.isFavorite,
                            id: _editedProduct.id,
                            title: _editedProduct.title,
                            description: _editedProduct.description,
                            price: double.parse(value!),
                            imageurl: _editedProduct.imageurl);
                      },
                    ),
                    TextFormField(
                      decoration: InputDecoration(
                        labelText: 'Description',
                      ),
                      initialValue: _initvalues['description'],
                      maxLines: 15,
                      keyboardType: TextInputType.multiline,
                      focusNode: _descriptionfocusnode,
                      onSaved: (value) {
                        _editedProduct = Products(
                            isFavorite: _editedProduct.isFavorite,
                            id: _editedProduct.id,
                            title: _editedProduct.title,
                            description: value.toString(),
                            price: _editedProduct.price,
                            imageurl: _editedProduct.imageurl);
                      },
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Container(
                          width: 100,
                          height: 100,
                          margin: EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            border: Border.all(width: 1, color: Colors.grey),
                          ),
                          child: _iamgecontroller.text.isEmpty
                              ? Text('Enter a URL')
                              : FittedBox(
                                  child: Image.network(
                                    _iamgecontroller.text,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                        ),
                        Expanded(
                          child: TextFormField(
                            decoration: InputDecoration(labelText: 'Image URL'),
                            keyboardType: TextInputType.url,
                            textInputAction: TextInputAction.done,
                            controller: _iamgecontroller,
                            focusNode: _imagefocusnode,
                            onEditingComplete: () {
                              setState(() {});
                            },
                            onFieldSubmitted: (_) {
                              _saveform();
                            },
                            onSaved: (value) {
                              _editedProduct = Products(
                                  isFavorite: _editedProduct.isFavorite,
                                  id: _editedProduct.id,
                                  title: _editedProduct.title,
                                  description: _editedProduct.description,
                                  price: _editedProduct.price,
                                  imageurl: value.toString());
                            },
                          ),
                        )
                      ],
                    )
                  ],
                ),
              ),
            ),
    );
  }
}
